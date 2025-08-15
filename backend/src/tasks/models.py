from django.db import models
from tools.models import TimeStampedModel
from users.models import User
from workspaces.models import Workspace
from projects.models import Project

from datetime import date
from django.utils import timezone



# Create your models here.

def task_image_upload_path(instance, filename):
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
    image = models.ImageField(null=True,blank=True , upload_to= task_image_upload_path , default="defaults/tasks/default.png")
    out_dated = models.BooleanField(default = False)
    parent_task = models.ForeignKey( # if this is null so the task doesn't have parent_task it is directly inside the project
        'self', 
        related_name='sub_tasks',
        on_delete=models.CASCADE,
        null=True,
        blank=True
    )
    assignees = models.ManyToManyField(
        User,
        through="Assignee",
        through_fields=('task', 'assignee'),
        related_name='tasks'
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

    def save(self, *args , **kwargs):

        return super().save(*args , **kwargs)
    
    def change_status_when_start(self):
        if self.start_date <= timezone.now().date():
            self.status = 'in_progress'
            self.save()


class Assignee(TimeStampedModel):
    class Meta:
        db_table= 'assignees'
        unique_together = ['assignee', 'task']
    assignee = models.ForeignKey(User, related_name='assignments', on_delete=models.CASCADE, null=False, blank=False)
    task = models.ForeignKey(Task, related_name='assignees_assignments', on_delete=models.CASCADE, null=False, blank=False)


class Comment(TimeStampedModel):
    class Meta:
        db_table= 'comments'
    
    task = models.ForeignKey(Task, related_name='comments', on_delete=models.CASCADE)
    user = models.ForeignKey(User, related_name='own_comments', on_delete=models.CASCADE)
    body= models.CharField(max_length=65535) # "TEXT" length in mysql

    
class Inbox_Tasks(TimeStampedModel):
    class Meta:
        # app_label = "inbox_tasks"
        db_table = "inbox_tasks"
    
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=2000 , default= "There is no description")
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
    user = models.ForeignKey(User , on_delete=models.CASCADE)

    def save(self, *args , **kwargs):

        return super().save(*args , **kwargs)


