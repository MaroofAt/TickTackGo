from django.db.models import Q
from rest_framework.permissions import BasePermission

from tools.permissions import fetch_task_id
from tools.roles_check import is_task_project_owner , can_edit_task, is_task_project_member, is_task_pending

class IsTaskProjectCanEdit(BasePermission):
    message = 'The Authenticated User Can\'t Edit The Specified Task Or The Task Is Not Exist'

    def has_permission(self, request, view):
        task_id = fetch_task_id(request, view, "IsTaskProjectCanEdit", fetch_from_pk=True)
        return can_edit_task(user_id=request.user, task_id=task_id)

class IsTaskProjectOwner(BasePermission):
    message = 'The Authenticated User Is Not The Project/Workspace Owner'

    def has_permission(self, request, view):
        task_id = fetch_task_id(request, view, "IsTaskProjectCanEdit", fetch_from_pk=True)
        return is_task_project_owner(user_id=request.user,task_id=task_id)
    
class IsTaskProjectMember(BasePermission):
    message = 'The Authenticated User Is Not A Project Member'

    def has_permission(self, request, view):
        task_id = fetch_task_id(request, view, "IsTaskProjectCanEdit", fetch_from_pk=True)
        return is_task_project_member(user_id=request.user,task_id=task_id)
    
class IsEditableTask(BasePermission):
    message = 'The Task Is Not Editable (Is Not Pending)'

    def has_permission(self, request, view):
        task_id = fetch_task_id(request, view, "IsTaskProjectCanEdit", fetch_from_pk=True)
        return is_task_pending(task_id)