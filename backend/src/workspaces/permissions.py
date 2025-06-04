from rest_framework import permissions
from tools.permissions import fetch_workspace_id
from .models import Workspace , Workspace_Membership


class IsWorkspaceOwner(permissions.BasePermission):
    message = 'Authenticated User is not the Workspace Owner'

    def has_permission(self, request, view):
        workspace_id = fetch_workspace_id(request, view, "IsWorkspaceOwner")

        return Workspace.objects.filter(owner = request.user , id = workspace_id).exists()
    

class IsWorkspaceMember(permissions.BasePermission):
    message = "Authenticated User is not Member in the Required Workspace"

    def has_permission(self, request, view):
        workspace_id = fetch_workspace_id(request, view, "IsWorkspaceMember")

        if Workspace_Membership.objects.filter(member = request.user , workspace_id = workspace_id).exists():
            return True
        return False
