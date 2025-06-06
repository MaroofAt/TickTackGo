from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.decorators import action
from rest_framework import status 
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.pagination import PageNumberPagination
from rest_framework import filters



from drf_spectacular.utils import extend_schema

from datetime import timedelta

from .models import User , User_OTP
from .serializers import UserSerializer , RegisterSerializer
from django.utils import timezone
from .utils import send_otp_email_to_user
from .filters import UserFilter

from workspaces.serializers import InviteSerializer , ShowInvitesSerializer
from workspaces.models import Invite , Workspace_Membership

from workspaces.permissions import IsWorkspaceMember, IsWorkspaceOwner
from projects.permissions import IsProjectWorkspaceMember , IsProjectWorkspaceOwner , CanEditProject


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    # Pagination
    pagination_class = PageNumberPagination
    pagination_class.page_size=50
    pagination_class.max_page_size=120
    pagination_class.page_size_query_param='size'
    # filtering/searching/ordering
    filter_backends = [
        DjangoFilterBackend,
        filters.SearchFilter,
        filters.OrderingFilter,
    ]
    filterset_class = UserFilter
    search_fields = ['username', 'email']
    ordering_fields = ['username', 'email', 'created_at', 'updated_at']

    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action == 'list':
            self.permission_classes.append(IsWorkspaceMember)
        if self.action == 'retrieve' :
            self.permission_classes.append(IsProjectWorkspaceMember)
        if self.action == 'create':
            self.permission_classes.append(IsProjectWorkspaceOwner)
        return super().get_permissions()

    def get_queryset(self):
        qs = super().get_queryset()

        if not self.request.user.is_staff:
            qs = qs.filter(username = self.request.user.username)

        return qs
    
    @extend_schema(
        summary="List",
        operation_id="list",
        description="get all users",
        tags=["Users"],
    )
    def list(self, request, *args, **kwargs):
        # return super().list(request, *args, **kwargs)
        qr = User.objects.filter().all()

        page = self.paginate_queryset(qr)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(qr, many=True)
        return Response(serializer.data)
    
    @extend_schema(
        summary="Retrieve",
        operation_id="retrieve",
        description="get one user",
        tags=["Users"],
    )
    def retrieve(self, request, pk , *args, **kwargs):
        # return super().retrieve(request, *args, **kwargs)
        qr = User.objects.filter(id=pk).first()
        serializer = self.get_serializer(qr)
        return Response(serializer.data)
    @extend_schema(exclude=True)
    def create(self, request, *args, **kwargs):
             return Response(
            {"detail": "Method not allowed"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )
    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs):
        return super().update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs):
        return super().partial_update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)


    @extend_schema(
        summary="Register",
        operation_id="register",
        description="registering the user (just for testing [without verification] )",
        tags=["Users/Auth"],
    )
    @action(detail=False , methods=['post'] , serializer_class=RegisterSerializer , url_path='register')
    def register(self , request):
        serializer = self.serializer_class(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status = status.HTTP_201_CREATED)
        return Response(serializer.data , status = status.HTTP_400_BAD_REQUEST)
    
    @extend_schema(
        summary="Send OTP",
        operation_id="send_otp",
        description="sending otp for the specified email in the request (to check that the user is the email owner) ",
        tags=["Users/Auth"],
    )
    @action(detail=False , methods=['post'] ,url_path='send_otp')
    def send_otp(self , request):
        email = request.data.get('email')
        if not email:
            return Response(
                {'error': 'Email is required'},
                status=status.HTTP_400_BAD_REQUEST
            )
        send_otp_email_to_user(email)

        return Response(
            {'message': 'OTP has been sent to your email'},
            status=status.HTTP_200_OK
        )
    
    @extend_schema(
        summary="Verify And Register",
        operation_id="verify_register",
        description="verifying the otp and register the user (for production) ",
        tags=["Users/Auth"],
    )
    @action(detail=False , methods=['post'] , serializer_class=RegisterSerializer ,url_path='verify_register')
    def verify_register(self , request):
        email = request.data.get('email')
        otp = request.data.get('otp')
        if not email:
            return Response(
                {'error': 'Email is required'},
                status=status.HTTP_400_BAD_REQUEST
            )
        if not otp:
            return Response(
                {'error': 'OTP is required'},
                status=status.HTTP_400_BAD_REQUEST
            )

        old_otps = User_OTP.objects.filter(expires_at__lt = timezone.now()).delete()
        
        if not User_OTP.objects.filter(otp=otp).exists():
            return Response(
                {'error': 'OTP Does Not Match'},
                status=status.HTTP_406_NOT_ACCEPTABLE
            )
        table_otp = User_OTP.objects.get(otp=otp)
        if table_otp.created_at < timezone.now() - timedelta(minutes=5):
            table_otp.delete()
            return Response(status=status.HTTP_410_GONE)

        serializer = self.serializer_class(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status = status.HTTP_201_CREATED)
        return Response(serializer.data , status = status.HTTP_400_BAD_REQUEST)
    

    # Invite section

    @extend_schema(
        summary="Show Invites ",
        operation_id="show_invites",
        description="show all invites for the user  ",
        tags=["Users/Invite"],
    )
    @action(detail=False , methods=['get'] , serializer_class=ShowInvitesSerializer)
    def show_invites(self , request):
        Invite.objects.filter(expire_date__lt = timezone.now()).delete()

        invites = Invite.objects.filter(receiver=request.user , status = 'pending').all()
        serializer = self.get_serializer(invites , many = True)
        
        # return Response({"receiver_id": request.user.id , "invites": serializer.data} , status=status.HTTP_200_OK)
        return Response(serializer.data , status=status.HTTP_200_OK)


    @extend_schema(
        summary="Accept Invite",
        operation_id="accept_invite",
        description="user can accept the invite (just send the invite_id to make the specific invite accepted ) ",
        tags=["Users/Invite"],
        request= {
            'application/json':{
                'type': 'object',
                'properties':{
                    'invite': {'type':'integer' , 'example':1}
                },
                'required':['invite']
            }
        }
    )
    @action(detail=False , methods=['post'] , serializer_class=InviteSerializer)
    def accept_invite(self , request):
        # print("Aliiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii")
        Invite.objects.filter(expire_date__lt = timezone.now()).delete()
        if not request.data.get('invite'):
            return Response({"message": "the invite is required!"}, status.HTTP_400_BAD_REQUEST)
        
        invite = Invite.objects.filter(id=request.data.get('invite')).first()
        
        if not invite:
            return Response({"message": "the invite specified doesn't exist!  maybe it expired :( "}, status.HTTP_400_BAD_REQUEST)
        if not invite.receiver == request.user:
            return Response({"message": "the invite specified doesn't belong to the authenticated user!"}, status.HTTP_400_BAD_REQUEST)
        if not invite.valid_invite():
            return Response({"message": "the invite specified status isn't pending! it can't be updated"}, status.HTTP_400_BAD_REQUEST)
        
        invite.status = 'accepted'
        invite.save()

        Workspace_Membership.objects.create(
            member = request.user,
            workspace = invite.workspace,
            role = 'member'
        )

        serializer = self.get_serializer(invite)
        return Response(serializer.data , status=status.HTTP_201_CREATED)
    
    @extend_schema(
        summary="Reject Invite",
        operation_id="reject_invite",
        description="user can reject the invite (just send the invite_id to make the specific invite rejected ) ",
        tags=["Users/Invite"],
        request= {
            'application/json':{
                'type': 'object',
                'properties':{
                    'invite': {'type':'integer' , 'example':1}
                },
                'required':['invite']
            }
        }
    )
    @action(detail=False , methods=['post'] , serializer_class=InviteSerializer)
    def reject_invite(self , request):
        Invite.objects.filter(expire_date__lt = timezone.now()).delete()
        if not request.data.get('invite'):
            return Response({"message": "the invite is required!"}, status.HTTP_400_BAD_REQUEST)
        
        invite = Invite.objects.filter(id=request.data.get('invite')).first()
        
        if not invite:
            return Response({"message": "the invite specified doesn't exist!  maybe it expired :( "}, status.HTTP_400_BAD_REQUEST)
        if not invite.receiver == request.user:
            return Response({"message": "the invite specified doesn't belong to the authenticated user!"}, status.HTTP_400_BAD_REQUEST)
        if not invite.valid_invite():
            return Response({"message": "the invite specified status isn't pending! it can't be updated"}, status.HTTP_400_BAD_REQUEST)
        
        invite.delete()
        return Response(None , status.HTTP_202_ACCEPTED)

              


class GoogleAuthView(APIView):
    permission_classes = [IsAuthenticated]
    
    @extend_schema(exclude=True)
    def post(request):
        refresh = RefreshToken.for_user(request.user)
        return Response({
            'refresh_token': str(refresh),
            'access_token': str(refresh.access_token)
        }, status.HTTP_202_ACCEPTED)
    
