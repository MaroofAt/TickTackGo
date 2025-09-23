from django.db.models import Q
from rest_framework.permissions import BasePermission

from tools.permissions import fetch_task_id
from tools.roles_check import is_task_project_owner , can_edit_task, is_task_project_member, is_task_pending
from .models import Task
from projects.models import Project

class IsTaskProjectCanEdit(BasePermission):
    message = 'The Authenticated User Can\'t Edit The Specified Task Or The Task Is Not Exist'

    def has_permission(self, request, view):
        # task_id = view.kwargs.get('task_id') or request.data.get('task_id')
        # print(f'/////////////////////////{request.data}////////////////////////////////')
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
    
class TaskProjectNotArchived(BasePermission):
    message = "This Project Is Archived"

    def has_permission(self, request, view):
        task_id = fetch_task_id(request, view, "TaskProjectNotArchived", fetch_from_pk=True)
        if not Task.objects.filter(id=task_id).exists():
            return False
        task = Task.objects.get(id=task_id)
        
        
        if not Project.objects.filter(id=task.project.id).exists():
            return False
        project = Project.objects.get(id=task.project.id)
        
        if project.ended:
            return False
        return True