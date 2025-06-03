from django.shortcuts import render

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action

from drf_spectacular.utils import extend_schema

from tools.responses import method_not_allowed

from .models import Workspace , Workspace_Membership
from .serializers import WorkspaceSerializer , InviteSerializer

# Create your views here.
class WorkspaceViewSet(viewsets.ModelViewSet):
    queryset = Workspace.objects.all()
    serializer_class = WorkspaceSerializer
    permission_classes = [IsAuthenticated]

    def get_permissions(self):
        
        return super().get_permissions()

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
                'required': ['title']
            }
        }
    )
    def create(self, request, *args, **kwargs):
        return super().create(request, *args, **kwargs)
    
    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().partial_update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def list(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().list(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def retrieve(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().retrieve(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def destroy(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return method_not_allowed()
        return super().destroy(request, *args, **kwargs)
    
    # Invite section

    @action(detail=True , methods=['post'] , serializer_class=InviteSerializer)
    def invite_user(self , request ,pk):
        if request.data.get('receiver') == request.user.id:
            return Response({"message": "User can not invite himself :) "} , status=status.HTTP_400_BAD_REQUEST)
        member = Workspace_Membership.objects.filter(member = request.data.get('receiver') , workspace = request.data.get('workspace'))
        if member.exists():
            return Response({'message': 'User you invite is already a member in this workspace'} , status=status.HTTP_400_BAD_REQUEST)

        serializer = self.get_serializer(
            data={
                'sender':request.user.id,
                'status': 'pending',
                **request.data
            }
        )    
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status=status.HTTP_201_CREATED)
        
        return Response(serializer.errors , status=status.HTTP_400_BAD_REQUEST)
