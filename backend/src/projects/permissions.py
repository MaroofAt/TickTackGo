from rest_framework import permissions
from tools.permissions import fetch_project_id
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