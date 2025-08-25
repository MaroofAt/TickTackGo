from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import User
from services.fcm_service import NotificationService


@receiver(post_save, sender=User)
def send_welcome_notification(sender , instance , created , **kwargs):
    if created:
        service = NotificationService()
        service.send_to_user(
            user_id=instance.id,
            title="Welcome to Our App!",
            body=f"Hi {instance.username}, thanks for signing up!",
            data={
                "type": "welcome",
                "screen": "/welcome"
            }
        )        


