from django.db import models

class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now=False , auto_now_add=True , editable=False)
    updated_at = models.DateTimeField(auto_now=True , auto_now_add=False , editable=False)
    class Meta:
        abstract = True