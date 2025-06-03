from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated

from drf_spectacular.utils import extend_schema

from workspaces.permissions import IsMember

from tools.responses import exception_response , required_response , method_not_allowed

from .models import Project
from .serializers import ProjectSerializer

# Create your views here.
class ProjectViewSet(viewsets.ModelViewSet):
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer
    permission_classes = [IsAuthenticated, IsMember]


    def get_queryset(self):
        qs = super().get_queryset()
        qs = qs.filter(workspace_id=self.request.data.get('workspace'))
        return qs

    @extend_schema(
        summary="List Projects",
        operation_id="list_projects",
        description="Listing Authenticated User Project",
        tags=["Projects"],
    )
    def list(self, request, *args, **kwargs):
        try:
            if (not request.data.get('workspace')) and (not request.GET['workspace']): # for the permission to work
                return required_response('Workspace ID')
            return super().list(request, *args, **kwargs)
        except Exception as e:
            return exception_response(e)
    
    def retrieve(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().retrieve(request, *args, **kwargs)
    
    @extend_schema(
        summary="Create Project",
        operation_id="create_project",
        description="Creating new project inside the workspace",
        tags=["Projects"],
    )
    def create(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().create(request, *args, **kwargs)
    
    def destroy(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().destroy(request, *args, **kwargs)
    
    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().partial_update(request, *args, **kwargs)
