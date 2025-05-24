from django.db import models

import uuid

from tools.models import TimeStampedModel #auto insert the created_at & updated_at fields
from users.models import User

# Create your models here.
def workspace_image_upload_path(instance , filename):
    if not instance.id:
        # Handle case where instance isn't saved yet
        return f'Workspaces/temp/{filename}'
    return f'Workspaces/{instance.id}/{filename}'
class Workspace(TimeStampedModel):
    class Meta:
        db_table = 'workspaces'
        unique_together = ["title","owner"]
    title = models.CharField(max_length=255)
    description = models.CharField(max_length=65535) # "TEXT" length in mysql
    image = models.ImageField(
        null=True,
        blank=True,
        upload_to=workspace_image_upload_path
    ) #TODO put default photo
    owner = models.ForeignKey(User , related_name='owned_workspaces' , on_delete=models.CASCADE, null=False, blank=False)
    members = models.ManyToManyField(
        User,
        through= "Workspace_Membership",
        through_fields=("workspace", "member"),
        related_name='joined_workspaces'
    )
    code = models.UUIDField(default=uuid.uuid4 , unique=True , editable=False)

    def __str__(self):
        return self.name
    


class Workspace_Membership(TimeStampedModel):
    class Meta:
        db_table = 'workspace_membership'
    member = models.ForeignKey(User, related_name='workspace_memberships' , on_delete=models.CASCADE , null=False , blank=False)
    workspace = models.ForeignKey(Workspace , on_delete=models.CASCADE, related_name='workspace_members', null=False , blank=False)
    class WORKSPACE_MEMBERSHIP_ROLES(models.TextChoices):
        MEMBER = 'member'
        OWNER = 'owner'
    role = models.CharField(
        max_length=6,
        choices=WORKSPACE_MEMBERSHIP_ROLES.choices,
        default=WORKSPACE_MEMBERSHIP_ROLES.MEMBER
    )

    def __str__(self):
        return f' user {str(self.member)} is a member in workspace {str(self.workspace)} as {str(self.role)} '