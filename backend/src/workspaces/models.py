from django.db import models
from django.utils import timezone

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
        return self.title
    


class Workspace_Membership(TimeStampedModel):
    class Meta:
        db_table = 'workspace_membership'
        unique_together = ['member', 'workspace']
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
    


def default_invite_expire_date():
    from datetime import datetime
    return timezone.localdate() + timezone.timedelta(days=7)

class Invite(TimeStampedModel):
    class Meta:
        db_table = 'invites'
    
    sender = models.ForeignKey(User , related_name='sent_invites' , on_delete=models.CASCADE)
    receiver = models.ForeignKey(User , related_name='received_invites' , on_delete=models.CASCADE)
    workspace = models.ForeignKey(Workspace , related_name='invites' , on_delete=models.CASCADE)

    class Status_Choices(models.TextChoices):
        PENDING = 'pending',
        ACCEPTED = 'accepted',
        REJECTED = 'rejected',
        CANCELLED = 'cancelled'

    status = models.CharField(
        max_length=9,
        choices=Status_Choices,
        default=Status_Choices.PENDING
    )

    expire_date = models.DateField(default=default_invite_expire_date, editable=False)

    def save(self,*args,**kwargs):
        
        if (self.status != 'pending' and self.status != 'accepted' and self.status != 'rejected' and self.status != 'cancelled'):
            print(f'\n\nINVITE STATUS can\'t be {self.status}\n\n')
            return False
        
        if not self.id:
            if Invite.objects.filter(
                sender=self.sender,
                receiver=self.receiver,
                workspace=self.workspace,
                status='pending'
            ).exists():
                # print(f'\n\nTHIS INVITE ALREADY EXISTS!\n\n')
                raise Exception("THIS INVITE ALREADY EXISTS!")


        super().save(*args,**kwargs)
        return True
    
    def valid_invite(self):
        if self.status == 'pending':
            return True
        return False
    