from rest_framework import permissions
from tools.permissions import fetch_project_id
from workspaces.models import Workspace_Membership

from .models import Project, Project_Membership

class IsProjectMember(permissions.BasePermission):
    message= "Authenticated User is not a Project Member"

    def has_permission(self, request, view):
        project_id = fetch_project_id(request, view, "IsProjectMember")
        
        if Project_Membership.objects.filter(project_id = project_id , member = request.user).exists():
            return True
        return False

class CanEditProject(permissions.BasePermission):
    message= "Authenticated User can't Edit Project"

    def has_permission(self, request, view):
        project_id = fetch_project_id(request, view, "CanEditProject")
        
        if Project_Membership.objects.filter(project_id = project_id , member = request.user).exists():
            return True
        return False
    
class IsProjectWorkspaceMember(permissions.BasePermission):
    message = "Authenticated User is not Member in the Required Workspace or the Project is not Exist"

    def has_permission(self, request, view):
        project_id = fetch_project_id(request, view, "IsProjectWorkspaceMember", fetch_from_pk=True)
        if not Project.objects.filter(id=project_id).exists():
            return False
        project = Project.objects.get(id=project_id)
        if Workspace_Membership.objects.filter(member = request.user , workspace = project.workspace).exists():
            return True
        return False
class IsProjectWorkspaceOwner(permissions.BasePermission):
    message = "Authenticated User is not the Workspace Owner"

    def has_permission(self, request, view):
        project_id = fetch_project_id(request, view, "IsProjectWorkspaceOwner", fetch_from_pk=True)
        if not Project.objects.filter(id=project_id).exists():
            return False
        project = Project.objects.get(id=project_id)
        if Workspace_Membership.objects.filter(member=request.user , workspace=project.workspace, role='owner').exists():
            return True
        return False