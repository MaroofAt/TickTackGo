from django.db import models
from django.utils import timezone
from django.conf import settings
from django.core.signing import TimestampSigner , SignatureExpired , BadSignature


import uuid

from .utils.crypto import Crypto


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
        upload_to=workspace_image_upload_path,
        default="defaults/workspaces/default.png"
    )
    owner = models.ForeignKey(User , related_name='owned_workspaces' , on_delete=models.CASCADE, null=False, blank=False)
    members = models.ManyToManyField(
        User,
        through= "Workspace_Membership",
        through_fields=("workspace", "member"),
        related_name='joined_workspaces'
    )
    user_points = models.ManyToManyField(
        User,
        through= "Points",
        through_fields=("workspace", "user"),
        related_name='points'
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
    
class Points(TimeStampedModel):
    class Meta:
        db_table = 'points'
        unique_together = ['user', 'workspace']
    
    total = models.IntegerField(default=0)
    important_mission_solver = models.IntegerField(default=0)
    hard_worker = models.IntegerField(default=0)
    discipline_member = models.IntegerField(default=0)

    user = models.ForeignKey(
        User,
        related_name= 'points_in_workspace',
        on_delete= models.CASCADE,
        null=False,
        blank=False
    )
    workspace = models.ForeignKey(
        Workspace,
        related_name= 'the_user_points',
        on_delete= models.CASCADE,
        null=False,
        blank=False
    )


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


def workspace_invitation_expiring_date_time():
    return timezone.now() + timezone.timedelta(hours=24)
class Workspace_Invitation(TimeStampedModel):
    class Meta:
        db_table = 'workspace_invitations'
    
    workspace = models.ForeignKey(Workspace , on_delete=models.CASCADE , related_name='invitation_links')
    token = models.CharField(max_length=255 , unique=True , editable=False)
    link = models.CharField(max_length=255 , unique=True)
    expires_at = models.DateTimeField(editable=False)
    valid = models.BooleanField(default=True)

    def save(self , *args , **kwargs ):
        print("///////////////////////////////////////////////////////////////////////////////////")
        if not self.id:
            if Workspace_Invitation.objects.filter(
                workspace = self.workspace,
                valid = True
            ).exists():
                raise Exception('This Workspace already have an invitation link')
            
            self.token = self.create_Invitation_token()

            crypto = Crypto()
            encrypted_token = crypto.encrypt(str(self.token))
            self.link = f'{settings.BASE_URL}/invite-link/{encrypted_token}/join-us'
            # print(f'{self.link}////////////////////////////////////////////////////////////////////////')
            self.expires_at = workspace_invitation_expiring_date_time()
        return super().save(*args , **kwargs)
    
    def create_Invitation_token(self):
        workspace = Workspace.objects.filter(id = self.workspace.id).first()
        signer = TimestampSigner()
        return signer.sign(str(workspace.code))
    
    def did_expired(self):
        return (self.expires_at < timezone.now())
    
    # def is_invitation_valid(self):
    #     try:
    #         if self.expires_at < timezone.now():
    #             return False
    #         signer = TimestampSigner()
            
    #         try:
    #             original = signer.unsign(self.token , max_age=(60*60*24))
    #             return True
    #         except SignatureExpired:
    #             return False
    #         except BadSignature:
    #             return False
    #     except Exception as e:
    #         return e
        
        

