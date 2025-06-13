from django.shortcuts import render

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action

from drf_spectacular.utils import extend_schema


from tools.responses import method_not_allowed


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
        return super().create(request, *args, **kwargs)

    
    @extend_schema(
        summary="List Workspaces",
        operation_id="list_workspaces",
        description="Getting All Workspaces Which The Authenticated-User Is A Member Of",
        tags=["Workspaces"],
    )
    def list(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return super().list(request, *args, **kwargs)
    @extend_schema(
        summary="Retrieve Workspace",
        operation_id="retrieve_workspaces",
        description="Retrieving The Workspace Specified",
        tags=["Workspaces"],
    )
    def retrieve(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return super().retrieve(request, *args, **kwargs)
    
    
    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().partial_update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def destroy(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().destroy(request, *args, **kwargs)
    
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
        
        sender = Workspace_Membership.objects.filter(member = request.user.id).first()
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
