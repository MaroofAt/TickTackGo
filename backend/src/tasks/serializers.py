from django.db import transaction
from rest_framework import serializers
from .models import Task, Assignee
from users.models import User

class TaskSerializer(serializers.ModelSerializer):
    assignees = serializers.PrimaryKeyRelatedField(read_only=False,many=True, queryset=User.objects.all())
    class Meta:
        model = Task
        fields = [
            'id',
            'title',
            'description',
            'start_date',
            'due_date',
            'complete_date',
            'creator',
            'workspace',
            'project',
            'image',
            'out_dated',
            'parent_task',
            'assignees',
            'status',
            'priority',
            'locked',
            'reminder'
        ]
        extra_kwargs = {
            'id': {'read_only':True},
            'complete_date': {'read_only': True},
            'out_dated': {'read_only': True},
            'assignees': {'read_only': False}
        }

    
    def create(self, validated_data):
        if validated_data.get('assignees'):
            assignees = validated_data.pop('assignees')
            with transaction.atomic():
                instance = super().create(validated_data)
                for assignee in assignees:
                    if not Assignee.objects.filter(assignee=assignee,task_id=instance.id).exists():
                        Assignee.objects.create(
                            assignee=assignee,
                            task=instance
                        )
            return instance
        else:
            return super().create(validated_data)
    
    def update(self, instance, validated_data):
        print(f"\n\n{validated_data}\n\n")
        if validated_data.get('assignees'):
            assignees = validated_data.pop('assignees')
            with transaction.atomic():
                instance = super().update(instance=instance,validated_data=validated_data)
                for assignee in assignees:
                    if not Assignee.objects.filter(assignee=assignee,task_id=instance.id).exists():
                        Assignee.objects.create(
                            assignee=assignee,
                            task=instance
                        )
            return instance
        else:
            return super().update(instance=instance,validated_data=validated_data)