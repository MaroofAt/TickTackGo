from celery import shared_task
from django.utils import timezone
from tasks.models import Task
from tools.notify import send
from users.models import User
from workspaces.models import Workspace
from tools.dependencie_functions import can_start
import requests
import json
#from services.fcm_service import send_to_user

@shared_task
def check_task_statuses():
    tasks = Task.objects.filter(
        status='pending',
        start_date__lte = timezone.now().date()
    )
    print(f'\n\n{tasks}\n\n')

    for task in tasks:
        # if can_start(task.id):
        #     continue
        task.status = 'in_progress'
        task.save()
        users = User.objects.filter(task.assignees)
        workspace = Workspace.objects.filter(workspace=task.workspace.id)
        owner = workspace.owner.id
        users.append(owner)
        result = send( users, 'Task Started ' , f'{task.title} have been started ')


@shared_task
def check_task_reminders():
    now = timezone.now()

    tasks = Task.objects.filter(
        reminder__lte=now,
        reminder_sent=False
    )

    for task in tasks:
        # send_reminder_alert(task.id)
        task.reminder_sent=True
        task.save()


    return f"Checked reminders found {tasks.count()} task reminder"


# @shared_task
# def send_reminder_alert(task_id):
#     try:
#         task = Task.objects.filter(task_id).first()
#         user = task.user

#         body_data = {
#             'type': 'task_reminder',
#             'task_id': task.id,
#             'title': task.title,
#             'message': f"Reminder: {task.title} is due soon!",
#             'user_id': user.id,
#         }
#         #I have to check it from shadiiiiiiiiiiiiiiiiiiiiii
#         webhook_url = "https://localhost:8000/api/reminder"
#         response = requests.post(
#             webhook_url,
#             json=body_data,
#             headers={'Content-Type': 'application/json'}
#         )
#         if response.status_code == 200:
#             print(f"Reminder sent successfully for task: {task.title}")
#             return f"Notification sent for task {task.id}"
#         else:
#             print(f"Failed to send reminder for task {task.id}: {response.status_code}")
#             return f"Failed to send notification for task {task.id}"
#     except Task.DoesNotExist:
#         print(f"Task with id {task_id} not found")
#         return f"Task {task_id} not found"
#     except Exception as e:
#         print(f"Error sending reminder for task {task_id}: {str(e)}")
#         return f"Error: {str(e)}"