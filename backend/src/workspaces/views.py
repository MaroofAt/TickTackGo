from django.db.models import Max

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action

from drf_spectacular.utils import extend_schema , OpenApiExample , OpenApiParameter

from django.db import IntegrityError
from rest_framework.exceptions import ValidationError

from tools.responses import method_not_allowed, exception_response, required_response
from tools.roles_check import is_workspace_owner , is_workspace_member


from .models import Workspace , Workspace_Membership , Invite , Points
from .serializers import WorkspaceSerializer , InviteSerializer , PointsSerializer
from django.utils import timezone
from .permissions import IsWorkspaceMember, IsWorkspaceOwner

# Create your views here.
class WorkspaceViewSet(viewsets.ModelViewSet):
    queryset = Workspace.objects.all()
    serializer_class = WorkspaceSerializer
    permission_classes = [IsAuthenticated]

    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action == 'retrieve':
            self.permission_classes.append(IsWorkspaceMember)
        if self.action == 'kick_member' or self.action == 'get_user_points':
            self.permission_classes.append(IsWorkspaceOwner)

        return super().get_permissions()
    def get_queryset(self):
        qs = super().get_queryset()
        if self.action == 'list' or self.action == 'retrieve':
            qs = qs.filter(members=self.request.user)
        return qs

    @extend_schema(
        summary="Create Workspace",
        operation_id="create_workspace",
        description="Creating new workspace and setting the authenticated user as its owner | user has limited workspace count allowed",
        tags=["Workspaces"],
        request={
            'multipart/form-data': {
                'type': 'object',
                'properties': {
                    'title': {'type': 'string', 'example': 'Team Workspace 1'},
                    'description': {'type': 'string', 'example': 'Our Team Workspace'},
                    'image': {'type': 'string' , 'format': 'binary'}
                },
                'required': ['title', 'image']
            },
            'application/json': {
                'type': 'object',
                'properties': {
                    'title': {'type': 'string', 'example': 'Team Workspace 1'},
                    'description': {'type': 'string', 'example': 'Our Team Workspace'},
                },
                'required': ['title']
            },
        }
    )
    def create(self, request, *args, **kwargs):
        try:
            return super().create(request, *args, **kwargs)
        except ValidationError as ve:
            return Response(str(ve), status=status.HTTP_400_BAD_REQUEST)
        except IntegrityError as ie:
            return Response(str(ie), status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return exception_response(e)

    
    @extend_schema(
        summary="List Workspaces",
        operation_id="list_workspaces",
        description="Getting All Workspaces Which The Authenticated-User Is A Member Of",
        tags=["Workspaces"],
    )
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)
    @extend_schema(
        summary="Retrieve Workspace",
        operation_id="retrieve_workspaces",
        description="Retrieving The Workspace Specified",
        tags=["Workspaces"],
        examples=[
            OpenApiExample(
                'Response 200',
                value ={
                        "id": 1,
                        "title": "Team Workspace 1",
                        "description": "Our Team Workspace",
                        "image": 'null',
                        "owner": {
                            "username": "Marouf",
                            "email": "m@m.com",
                            "image": "http://127.0.0.1:8000/media/defaults/user/default.png",
                            "how_to_use_website": "own_tasks_management",
                            "what_do_you_do": "software_or_it",
                            "how_did_you_get_here": "google_search",
                            "created_at": "2025-06-07T13:02:34.790977Z",
                            "updated_at": "2025-06-07T13:02:34.791022Z"
                        },
                        "members": [
                            {
                            "member": {
                                "username": "A",
                                "email": "a@a.com",
                                "image": "/media/defaults/user/default.png",
                                "how_to_use_website": "own_tasks_management",
                                "what_do_you_do": "software_or_it",
                                "how_did_you_get_here": "google_search",
                                "created_at": "2025-06-07T13:03:39.898582Z",
                                "updated_at": "2025-06-07T13:03:39.898639Z"
                            },
                            "role": "member",
                            "created_at": "2025-06-07T13:06:10.084406Z",
                            "updated_at": "2025-06-07T13:06:10.084426Z"
                            }
                        ],
                        "projects": [
                            {
                            "id": 1,
                            "title": "Project 1",
                            "color": "#ff0000",
                            "ended": False,
                            "sub_projects": [
                                {
                                "id": 3,
                                "title": "Project 3",
                                "color": "#ff0000",
                                "ended": False,
                                "sub_projects": [
                                    {
                                    "id": 5,
                                    "title": "Project 4",
                                    "color": "#ff0000",
                                    "ended": False,
                                    "sub_projects": []
                                    }
                                ]
                                }
                            ]
                            },
                            {
                            "id": 2,
                            "title": "Project 2",
                            "color": "#ff0000",
                            "ended": False,
                            "sub_projects": []
                            }
                        ],
                        "created_at": "2025-06-07T13:04:29.089513Z",
                        "updated_at": "2025-06-07T13:04:29.089539Z" 
                    },
                response_only=True
            )
        ]
    )
    def retrieve(self, request, *args, **kwargs):
        return super().retrieve(request, *args, **kwargs)
    
    
    # @extend_schema(exclude=True)
    # def update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
    #     return method_not_allowed()
    #     return super().update(request, *args, **kwargs)
    @extend_schema(
        summary="Partial Update Workspace",
        operation_id="partial_update_workspace",
        description="Updating The Workspace Specified",
        tags=["Workspaces"],
        request={
            'multipart/form-data': {
                'type': 'object',
                'properties': {
                    'title': {'type': 'string', 'example': 'Team Workspace 1'},
                    'description': {'type': 'string', 'example': 'Our Team Workspace'},
                    'image': {'type': 'string' , 'format': 'binary'}
                }
            },
            'application/json': {
                'type': 'object',
                'properties': {
                    'title': {'type': 'string', 'example': 'Team Workspace 1'},
                    'description': {'type': 'string', 'example': 'Our Team Workspace'},
                }
            },
        }
    )
    def partial_update(self, request, *args, **kwargs):
        pk = kwargs.get('pk')
        if not is_workspace_owner(request.user.id,pk):
            return Response(
            {"detail": "User is not the owner"},
            status=status.HTTP_400_BAD_REQUEST
            )
        if ( request.data.get('members') or request.data.get('owner')):
            return Response(
            {"detail": "you can't change members or owners"},
            status=status.HTTP_400_BAD_REQUEST
            )
        return super().partial_update(request, *args, **kwargs)
    @extend_schema(
        summary="Delete Workspace",
        operation_id="delete_workspace",
        description="Deleting The Workspace Specified",
        tags=["Workspaces"],
    )
    def destroy(self, request, *args, **kwargs):
        pk = kwargs.get('pk')
        if is_workspace_owner(request.user.id,pk):
            return super().destroy(request, *args, **kwargs)
        return Response(
        {"detail": "User is not the owner"},
        status=status.HTTP_400_BAD_REQUEST
    )
    
    # Points

    @extend_schema(
        summary="Get User Points",
        operation_id="get_user_points",
        description="owner can get users points",
        tags=["Workspaces/Points"],
        parameters=[
            OpenApiParameter(
                name='user',
                type=int,
                description='user id that u wants to get his/her points',
                required=True
            )
        ]
    )
    @action(detail=True , methods=['get'] , serializer_class=PointsSerializer)
    def get_user_points(self , request , pk):
        try:
            user_id = request.GET['user']
            if not user_id:
                return required_response('user (query-param)')
            points_object = Points.objects.filter(user_id=user_id, workspace_id=pk).first()
            if not points_object:
                return Response({'detail': 'points_object not found!'}, status=status.HTTP_404_NOT_FOUND)
            serializer = self.get_serializer(points_object)
            return Response(serializer.data , status=status.HTTP_200_OK)
        except Exception as e:
            return exception_response(e)

    @extend_schema(
        summary='Get Points Statistics',
        operation_id='get_points_statistics',
        description='getting points statistics such as the best hard-worker and the best important-mission-solver and  the best discipline-member',
        tags=['Workspaces/Points']
    )
    @action(detail=True , methods=['get'])
    def get_points_statistics(self, request, pk):
        instance = self.get_object()
        
        best_hard_work_record = Points.objects.filter(workspace=instance).order_by('-hard_worker').first()
        best_important_mission_solver_record = Points.objects.filter(workspace=instance).order_by('-important_mission_solver').first()
        best_discipline_member_record = Points.objects.filter(workspace=instance).order_by('-discipline_member').first()
        best_member_record = Points.objects.filter(workspace=instance).order_by('-total').first()
        
        return Response(
            {
                "best_hard_worker":{
                    "user_id" : best_hard_work_record.user_id,
                    "hard_worker_points": best_hard_work_record.hard_worker
                },
                "best_important_mission_solver_record":{
                    "user_id" : best_important_mission_solver_record.user_id,
                    "important_mission_solver_points": best_important_mission_solver_record.important_mission_solver
                },
                "best_discipline_member_record":{
                    "user_id" : best_discipline_member_record.user_id,
                    "discipline_member_points": best_discipline_member_record.discipline_member
                },
                "best_member_record":{
                    "user_id" : best_member_record.user_id,
                    "total_points": best_member_record.total
                }
            },
            status=status.HTTP_200_OK
        )


    # Invite section
    
    @extend_schema(
        summary="Invite User",
        operation_id="invite_user",
        description="Owner can invite User ",
        tags=["Workspaces/Invite"],
        request={
            'application/json':{
                'type': 'object',
                'properties':{
                    'receiver': {'type':'integer', 'example':1}
                },
                'required': ['receiver']
            }
        }
    )
    @action(detail=True , methods=['post'] , serializer_class=InviteSerializer)
    def invite_user(self , request , pk):
        if request.data.get('receiver') == request.user.id:
            return Response({"message": "User can not invite himself :) "} , status=status.HTTP_400_BAD_REQUEST)
        member = Workspace_Membership.objects.filter(member = request.data.get('receiver') , workspace = pk)
        if member.exists():
            return Response({'message': 'User you invite is already a member in this workspace'} , status=status.HTTP_400_BAD_REQUEST)


        sender = Workspace_Membership.objects.filter(member = request.user.id)
        if not sender.exists():
            return Response({'message': 'Sender is not in workspace'} , status=status.HTTP_400_BAD_REQUEST)
        
        sender = Workspace_Membership.objects.filter(member = request.user.id , workspace=pk).first()
        if sender.role != 'owner':
            return Response({'message': 'Sender is not the Owner of the workspace'} , status=status.HTTP_400_BAD_REQUEST)

        serializer = self.get_serializer(
            data={
                'workspace':pk,
                'sender':request.user.id,
                'status': 'pending',
                **request.data
            }
        )    
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status=status.HTTP_201_CREATED)
        
        return Response(serializer.errors , status=status.HTTP_400_BAD_REQUEST)
    
    @extend_schema(
        summary = "Cancel Invite",
        operation_id = "cancel_invite",
        description = "Owner how send invite can cancel the invite",
        tags = ["Workspaces/Invite"]
    )
    @action(detail=True , methods=['post'] , serializer_class=InviteSerializer)
    def cancel_invite (self , request , pk):
        Invite.objects.filter(expire_date__lt = timezone.now()).delete()
        if not request.data.get('invite'):
            return Response({"message": "the invite is required!"}, status.HTTP_400_BAD_REQUEST)
        invite = Invite.objects.filter(id = request.data.get('invite')).first()
        
        sender = Workspace_Membership.objects.filter(member = request.user.id , workspace = pk)
        if not sender.exists():
            return Response({'message': 'you are not member in this workspace'} , status=status.HTTP_400_BAD_REQUEST)
        sender = Workspace_Membership.objects.filter(member = request.user.id , workspace = pk).first()
        print(sender.role)
        if sender.role != 'owner':
            return Response({'message': 'You are not the Owner of the workspace'} , status=status.HTTP_400_BAD_REQUEST)

        if not invite:
            return Response({"message":"the invite specified doesn't exist!  maybe it expired :( "} , status.HTTP_404_NOT_FOUND)
        if invite.sender != request.user:
            return Response({"message":"the invite specified doesn't belong to this owner"} , status.HTTP_400_BAD_REQUEST)
        if not invite.valid_invite():
            return Response({"message": "the invite specified status isn't pending! it can't be updated"}, status.HTTP_400_BAD_REQUEST)
        
        invite.status = 'cancelled'
        invite.save()
        return Response(None , status.HTTP_202_ACCEPTED)
    
    @extend_schema(
        summary = "Kick Member",
        operation_id = "kick_member",
        description = "Kick Member From Workspace",
        tags = ["Workspaces"],
        request={
            'application/json':{
                'type': 'object',
                'properties':{
                    'member':{'type':'integer' , 'example':1}
                }
            }
        }
    )
    @action(detail=True , methods=['post'])
    def kick_member(self, request, pk):
        try:
            if 'member' not in request.data:
                return required_response('member')
            member = request.data.get('member')
            if not is_workspace_member(member, pk):
                return Response(
                    {'detail': 'can\'t kick a person who is not a member of the workspace'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            membership_object = Workspace_Membership.objects.filter(member_id=member,workspace=pk).first()
            if not membership_object:
                return Response(
                    {"detail": 'membership doesn\'t exist'},
                    status=status.HTTP_404_NOT_FOUND
                )
            try:
                membership_object.delete()
            except Exception as ex:
                return Response(
                    {'error': 'can\'t delete the membership object'},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR
                )
            return Response(
                {},
                status=status.HTTP_204_NO_CONTENT
            )
        except Exception as e:
            return exception_response(e)
