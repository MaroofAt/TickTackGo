from rest_framework import permissions
from .models import Workspace , Workspace_Membership

class IsWorkspaceOwner (permissions.BasePermission):
    message = 'Authenticated User is not the Workespace Owner'

    def has_permission(self, request, view):
        # return super().has_permission(request, view)
        workespace_id = self.kwargs.get('pk')

        if not workespace_id:
            workespace_id = request.data.get('workespace')
            if not workespace_id:
                workespace_id = view.kwargs.get('workespace_id')

        return Workspace.objects.filter(owner = request.user , id = workespace_id).exists()
    

class IsWorkspaceMembre (permissions.BasePermission):
    message = "Authenticated User is not Member in the Required Workespace"

    def has_permission(self, request, view):
        # return super().has_permission(request, view)
        workespace_id = self.kwargs.get('pk')

        if not workespace_id:
            workespace_id = request.data.get('workespace')
            if not workespace_id:
                workespace_id = view.kwargs.get('workespace_id')

        membership = Workspace_Membership.objects.filter(user = request.user , workespace_id = workespace_id)
        if membership.exists():
            # membership = membership.get()
            # if membership.workespace_membership_roles == "member":
            return True
        return False