import os
from celery import Celery


os.environ.setdefault('DJANGO_SETTINGS_MODULE' , 'ticktackgo.settings')
app = Celery('ticktackgo')
app.config_from_object('django.conf:settings' , namespace='CELERY')
app.autodiscover_tasks()


app.conf.beat_schedule = {

    'check-task-reminders':{
        'task': 'tasks.tasks.check_task_reminders',
        'schedule': 60.0,
    },
    'check-task-statuses':{
        'task': 'tasks.tasks.check_task_statuses',
        'schedule': 300.0,
    }
    
}

