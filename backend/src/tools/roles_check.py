from workspaces.models import Workspace_Membership
from projects.models import Project_Membership , Project

def is_workspace_member(user_id,workspace_id):
    if Workspace_Membership.objects.filter(member_id=user_id,workspace_id=workspace_id).exists():
        return True
    return False

def is_project_member(user_id, project_id):
    if Project_Membership.objects.filter(member_id=user_id,project_id=project_id).exists():
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

def is_project_workspace_owner_or_editor(user_id , project_id):
    project = Project.objects.filter(id = project_id)
    if not project.exists():
        return False
    project = project.first()
    owner = Project_Membership.objects.filter(user_id = user_id , project_id = project_id)
    if not owner.exists():
        return False
    owner = owner.first()
    if owner.role == 'owner' or owner.role=='editor':
        return True
    return False


