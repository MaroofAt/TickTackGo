from django.db import models

from tools.models import TimeStampedModel

from workspaces.models import Workspace
from users.models import User

# Create your models here.
class Project(TimeStampedModel):
    class Meta:
        db_table = 'projects'
        unique_together = ['title', 'workspace']
    
    title = models.CharField(max_length=255)
    color = models.CharField(max_length=10 , default='#ffffff') # color code is 6 digits
    ended = models.BooleanField(default=False)
    workspace = models.ForeignKey(
        Workspace,
        related_name='projects',
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    parent_project = models.ForeignKey( # if this is null so the project doesn't have parent_project it is directly inside the workspace
        'self', # Project
        related_name='sub_projects',
        on_delete=models.CASCADE,
        null=True,
        blank=True
    )
    members = models.ManyToManyField(
        User,
        through= "Project_Membership",
        through_fields= ('project','member'),
        related_name= 'joined_projects'
    )

    def validate_color(self):
        if (self.color[0] != "#"):
            return False
        return True

    def save(self, *args , **kwargs):
        try:
            if (self.ended == True):
                raise Exception('This Project Has Ended! User Can\'t Edit It Anymore')
            if (not self.validate_color()):
                raise Exception('Color Code is Not Valid! ( it does not start with "#" )')
        except Exception as e:
            raise e
        return super().save(*args , **kwargs)
    

class Project_Membership(TimeStampedModel):
    class Meta:
        db_table = 'project_memberships'
        unique_together = ['member' , 'project']
    member = models.ForeignKey(User, related_name='project_memberships', on_delete=models.CASCADE, null=False , blank=False)
    project = models.ForeignKey(Project, related_name='memberships', on_delete=models.CASCADE, null=False , blank=False)
    class PROJECT_MEMBERSHIP_ROLE(models.TextChoices):
        OWNER = 'owner'
        EDITOR = 'editor'
        VIEWER = 'viewer'
    role = models.CharField(
        max_length=6,
        choices=PROJECT_MEMBERSHIP_ROLE,
        default=PROJECT_MEMBERSHIP_ROLE.VIEWER
    )

    def save(self, *args , **kwargs):
        try:
            # if((self.project.workspace.owner == self.member) and (self.role != 'owner')): #TODO
            #     raise Exception('Owner Can\'t Be With Another Role Inside The Project! (owner must be owner!).')
            if((self.role == 'owner') and (Project_Membership.objects.filter(project=self.project, role='owner').exists())):
                raise Exception('There Can\'t Be More Than One Owner For The Project !')
        except Exception as e:
            raise e
        return super().save(*args , **kwargs)
