from celery import shared_task
from django.utils import timezone
from tasks.models import Task
from tools.notify import send
from users.models import User
from workspaces.models import Workspace
from tools.dependencie_functions import can_start
#from services.fcm_service import send_to_user

@shared_task
def check_task_statuses():
    tasks = Task.objects.filter(
        status='pending',
        start_date__lte = timezone.now().date()
    )

    for task in tasks:
        if can_start(task.id):
            continue
        task.status = 'in_progress'
        task.save()
        users = User.objects.filter(task.assignees)
        workspace = Workspace.objects.filter(workspace=task.workspace.id)
        owner = workspace.owner.id
        users.append(owner)
        result = send( users, 'Task Started ' , f'{task.title} have been started ')
