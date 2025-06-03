from rest_framework import permissions
from .models import Workspace , Workspace_Membership


class IsOwner(permissions.BasePermission):
    message = 'Authenticated User is not the Workspace Owner'

    def has_permission(self, request, view):
        # return super().has_permission(request, view)
        workspace_id = request.data.get('workspace')
        if not workspace_id:
            workspace_id = view.kwargs.get('workspace_id')

        return Workspace.objects.filter(owner = request.user , id = workspace_id).exists()
    

class IsMember(permissions.BasePermission):
    message = "Authenticated User is not Member in the Required Workspace"

    def has_permission(self, request, view):
        # return super().has_permission(request, view)
        workspace_id = request.data.get('workspace')
        if not workspace_id:
            try:
                workspace_id = request.GET['workspace']
            except Exception as e:
                workspace_id = view.kwargs.get('workspace_id')
        if not workspace_id: # for debugging
            raise Exception('can\'t fetch workspace id from request or view in permissions.py in IsMember')

        membership = Workspace_Membership.objects.filter(member = request.user , workspace_id = workspace_id)
        if membership.exists():
            return True
            # membership = membership.get()
            # if membership.workspace_membership_roles == "member":
            #     return True

        return False