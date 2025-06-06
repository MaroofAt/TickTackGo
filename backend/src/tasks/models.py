from django.db import models
from tools.models import TimeStampedModel
from users.models import User
from workspaces.models import Workspace
from projects.models import Project

from datetime import date
from django.utils import timezone



# Create your models here.

def user_image_upload_path(instance, filename):
    if not instance.id:
        # Handle case where instance isn't saved yet
        return f'Tasks/temp/{filename}'
    return f'Tasks/{instance.id}/{filename}'

class Task(TimeStampedModel):
    class Meta:
        app_label = "tasks"
        db_table = "tasks"
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=2000 , default= "There is no description")
    start_date = models.DateField(auto_now_add=False , null=True, blank=True )
    due_date = models.DateField(auto_now_add=False , null=True, blank=True )
    complete_date = models.DateField(auto_now_add=False , null=True, blank=True )
    creator = models.ForeignKey(User , on_delete=models.CASCADE )
    workspace = models.ForeignKey(Workspace , on_delete=models.CASCADE )
    project = models.ForeignKey(Project , on_delete=models.CASCADE )
    image = models.ImageField(null=True,blank=True , upload_to=user_image_upload_path , default="defaults/task/task.png")
    out_dated = models.BooleanField(default = False)
    parent_task = models.ForeignKey( # if this is null so the task doesn't have parent_task it is directly inside the project
        'self', 
        related_name='sub_tasks',
        on_delete=models.CASCADE,
        null=True,
        blank=True
    )
    class Task_Status(models.TextChoices):
        PENDING = 'pending'
        IN_PROGRESS = 'in_progress'
        COMPLETED = 'completed'

    status = models.CharField(
        max_length=11,
        choices=Task_Status,
        default=Task_Status.PENDING
    )

    class Task_Priority(models.TextChoices):
        HIGH = 'high'
        MEDIUM = 'medium'
        LOW = 'low'

    priority = models.CharField(
        max_length=6,
        choices=Task_Priority,
        default=Task_Priority.MEDIUM
    )       

    locked = models.BooleanField(default=False)
    reminder = models.DateField(null=True, blank=True)

    def is_pending(self):
        if self.status == 'pending':
            return True
        return False

    def save(self, force_insert = ..., force_update = ..., using = ..., update_fields = ...):

        return super().save(force_insert, force_update, using, update_fields)
    
    def change_status_when_start(self):
        if self.start_date <= timezone.now().date():
            self.status = 'in_progress'
            self.save()