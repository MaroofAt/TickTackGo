from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated

from drf_spectacular.utils import extend_schema , OpenApiParameter , OpenApiExample

from workspaces.permissions import IsWorkspaceMember, IsWorkspaceOwner
from projects.permissions import IsProjectWorkspaceMember

from tools.responses import exception_response , required_response , method_not_allowed

from .models import Project
from .serializers import ProjectSerializer

# Create your views here.
class ProjectViewSet(viewsets.ModelViewSet):
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer

    
    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action == 'list':
            self.permission_classes.append(IsWorkspaceMember)
        if self.action == 'retrieve' or self.action == 'destroy':
            self.permission_classes.append(IsProjectWorkspaceMember)
        if self.action == 'create':
            self.permission_classes.append(IsWorkspaceOwner)
        return super().get_permissions()
    def get_queryset(self):
        qs = super().get_queryset()
        return qs
    def get_serializer_context(self):
        """
        if self.action == 'retrieve':
            return {
                
            }.update(super().get_serializer_context())
        """
        return super().get_serializer_context()
        
    

    @extend_schema(
        summary="List Projects",
        operation_id="list_projects",
        description="Listing Authenticated User Project",
        tags=["Projects"],
        parameters=[
            OpenApiParameter(
                name='workspace',
                type=int,
                description='workspace id that u wants to get its projects (authenticated user must be a member of this workspace)',
                required=True
            )
        ]
    )
    def list(self, request, *args, **kwargs):
        try:
            if (not request.data.get('workspace')) and (not request.GET['workspace']): # for the permission to work
                return required_response('Workspace ID')
            return super().list(request, *args, **kwargs)
        except Exception as e:
            return exception_response(e)
    

    @extend_schema(
        summary="Retrieve Projects",
        operation_id="retrieve_projects",
        description="Retrieve Project (the authenticated user must be a workspace member) ",
        tags=["Projects"],
    )
    def retrieve(self, request, *args, **kwargs):
        return super().retrieve(request, *args, **kwargs)
    
    @extend_schema(
        summary="Create Project",
        operation_id="create_project",
        description="Creating new project inside the workspace",
        tags=["Projects"],
        request={
            'application/json':{
                'type': 'object',
                'properties':{
                    'title': {'type':'string' , 'example':'Project 1'},
                    'color': {'type':'string' , 'example':'#ff0000'},
                    'workspace': {'type':'integer' , 'example':'1'},
                    'parent_project': {'type':'integer' , 'example':'1'},
                },
                'required':['title','workspace']
            }
        }
    )
    def create(self, request, *args, **kwargs):
        print(f'\n\nrequest.data = {request.data}\n\n')
        if not request.data.get('title'):
            return required_response('title')
        if not request.data.get('workspace'):
            return required_response('workspace')
        return super().create(request, *args, **kwargs)
    
    @extend_schema(
        summary="Delete Project",
        operation_id="delete_project",
        description="Deleting the specified project",
        tags=["Projects"],
    )
    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)
    
    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().update(request, *args, **kwargs)
    
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().partial_update(request, *args, **kwargs)
