from workspaces.models import Workspace_Membership , Workspace
from projects.models import Project_Membership , Project
from tasks.models import Task

def is_workspace_member(user_id,workspace_id):
    if Workspace_Membership.objects.filter(member_id=user_id,workspace_id=workspace_id).exists():
        return True
    return False
def is_workspace_owner(user_id,workspace_id):
    if Workspace.objects.filter(id=workspace_id,owner_id=user_id).exists():
        return True
    return False

def is_project_member(user_id, project_id):
    if Project_Membership.objects.filter(member_id=user_id,project_id=project_id).exists():
        return True
    return False
def is_project_owner(user_id, project_id):
    if Project_Membership.objects.filter(member_id=user_id, project_id=project_id, role='owner').exists():
        return True
    return False

def is_project_workspace_member(user_id, project_id):
    project = Project.objects.filter(id=project_id)
    if not project.exists():
        return False
    project = project.first()
    if Workspace_Membership.objects.filter(member_id=user_id,workspace_id=project.workspace).exists():
        return True
    return False

def can_edit_project(user_id , project_id):
    user = Project_Membership.objects.filter(user_id = user_id , project_id = project_id)
    if not user.exists():
        return False
    user = user.first()
    if user.role == 'owner' or user.role=='editor':
        return True
    return False

def can_edit_task(user_id , task_id):
    task = Task.objects.filter(id=task_id)
    if not task.exists():
        return False
    task = task.first()
    
    project = Project.objects.filter(id=task.project)
    if not project.exists():
        return False
    project = project.first()

    user = Project_Membership.objects.filter(user_id = user_id , project_id = project)
    if not user.exists():
        return False
    user = user.first()
    if user.role == 'owner' or user.role=='editor':
        return True
    return False


def is_creator(user_id , task_id):
    task = Task.objects.filter(id = task_id)
    if not task.exists():
        return False
    task = task.first()
    if user_id == task.creator:
        return True
    return False

def is_task_project_owner(user_id, task_id):
    task = Task.objects.filter(id=task_id)
    if not task.exists():
        return False
    task = task.first()
    
    project = Project.objects.filter(id=task.project)
    if not project.exists():
        return False
    project = project.first()

    if Project_Membership.objects.filter(member_id=user_id, project=project, role="owner").exists():
            return True
    return False

def is_task_project_member(user_id, task_id):
    task = Task.objects.filter(id=task_id)
    if not task.exists():
        return False
    task = task.first()
    
    project = Project.objects.filter(id=task.project)
    if not project.exists():
        return False
    project = project.first()

    if Project_Membership.objects.filter(member_id=user_id, project=project).exists():
            return True
    return False


