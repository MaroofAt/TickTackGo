from django.db import models
from django.contrib.auth.models import BaseUserManager , AbstractBaseUser , PermissionsMixin
from django.contrib.auth.hashers import make_password, check_password

from django.core.exceptions import ValidationError


from tools.models import TimeStampedModel #auto insert the created_at & updated_at fields


# Create your models here.

class CustomUserManager(BaseUserManager):
    def create_user(self , username , email , password = None , **extra_fields):
        if not username:
            raise ValueError('user Must have username')
        if not email:
            raise ValueError('user must have an email')
        email = self.normalize_email(email)
        user = self.model(username = username , email = email , **extra_fields)
        user.set_password(password)
        user.save()
        return user
    
    def create_superuser(self, username , email , password , **extra_fields):
        extra_fields.setdefault('is_staff' , True)
        extra_fields.setdefault('is_superuser' , True)
        extra_fields.setdefault('is_active' , True)

        return self.create_user(username , email , password , **extra_fields)


def user_image_upload_path(instance, filename):
    if not instance.id:
        # Handle case where instance isn't saved yet
        return f'Users/temp/{filename}'
    return f'Users/{instance.id}/{filename}'
class User(AbstractBaseUser , PermissionsMixin , TimeStampedModel):
    class Meta:
        db_table = 'users'
    username = models.CharField(max_length=100 , unique=True)
    email = models.EmailField(unique=True)
    image = models.ImageField( 
        upload_to=user_image_upload_path,
        default="defaults/user/default.png"
    ) #TODO put default photo
    class HOW_TO_USE_WEBSITE(models.TextChoices):
        OWN_TASKS_MANAGEMENT = 'own_tasks_management'
        SMALL_TEAM = 'small_team'
        MEDIUM_TEAM = 'medium_team'
    how_to_use_website = models.CharField(
        max_length=20,
        choices=HOW_TO_USE_WEBSITE.choices,
    )
    class WHAT_DO_YOU_DO(models.TextChoices):
        SOFTWARE_OR_IT = 'software_or_it'
        HR_OR_OPERATIONS = 'hr_or_operations'
        SALES_AND_MARKETING = 'sales_and_marketing'
        EDUCATION = 'education'
        FINANCE = 'finance'
        HEALTH = 'health'
        STUDENT = 'student'
        ARCHITECTURE_ENGINEER = 'architecture_engineer'
        OTHER = 'other'
    what_do_you_do = models.CharField(
        max_length=21,
        choices=WHAT_DO_YOU_DO.choices
    )
    class HOW_DID_YOU_GET_HERE(models.TextChoices):
        GOOGLE_SEARCH = 'google_search'
        FRIENDS = 'friends'
        YOUTUBE = 'youtube'
        INSTAGRAM = 'instagram'
        FACEBOOK = 'facebook'
    how_did_you_get_here = models.CharField(
        max_length=13,
        choices=HOW_DID_YOU_GET_HERE.choices
    )

    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    otp = models.CharField(max_length=6, null=True, blank=True)
    is_email_verified = models.BooleanField(default=False)
    otp_created_at = models.DateTimeField(auto_now=False , auto_now_add=True , editable=False , null=True, blank=True)

    objects = CustomUserManager() # connect this class to the CustomUserManager


    groups = models.ManyToManyField(
        'auth.Group',
        verbose_name='groups',
        blank=True,
        help_text='The groups this user belongs to.',
        related_name="custom_user_set",  # Important to avoid reverse name clashes
        related_query_name="user",
    )



    def __str__(self):
        return self.fullname