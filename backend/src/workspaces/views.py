from django.shortcuts import render

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action

from drf_spectacular.utils import extend_schema , OpenApiExample

from django.db import IntegrityError
from rest_framework.exceptions import ValidationError

from tools.responses import method_not_allowed, exception_response
from tools.roles_check import is_workspace_owner


from .models import Workspace , Workspace_Membership
from .serializers import WorkspaceSerializer , InviteSerializer
from .permissions import IsWorkspaceMember

# Create your views here.
class WorkspaceViewSet(viewsets.ModelViewSet):
    queryset = Workspace.objects.all()
    serializer_class = WorkspaceSerializer
    permission_classes = [IsAuthenticated]

    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action == 'retrieve':
            self.permission_classes.append(IsWorkspaceMember)

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
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        pk = kwargs.get('pk')
        if not is_workspace_owner(request.user.id,pk):
            return Response(
            {"detail": "User is not the owner"},
            status=status.HTTP_400_BAD_REQUEST
            )
        if ( request.data.get('members') and request.data.get('owner')):
            return Response(
            {"detail": "you can't change members or owners"},
            status=status.HTTP_400_BAD_REQUEST
            )
        return super().partial_update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def destroy(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        pk = kwargs.get('pk')
        if is_workspace_owner(request.user.id,pk):
            return super().destroy(request, *args, **kwargs)
        return Response(
        {"detail": "User is not the owner"},
        status=status.HTTP_400_BAD_REQUEST
    )
    
    # Invite section
    
    @extend_schema(
        summary="Invite User",
        operation_id="invite_user",
        description="Owner can invite User ",
        tags=["Workspaces/Invite"],
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
