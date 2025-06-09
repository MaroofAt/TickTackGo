from rest_framework import serializers
from .models import Task , Inbox_Tasks

class TaskSerializer(serializers.ModelSerializer):
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
            'status',
            'priority',
            'locked',
            'reminder'
        ]
        extra_kwargs = {
            'id': {'read_only':True},
            'complete_date': {'read_only': True},
            'out_dated': {'read_only': True},
            # 'creator': {'read_only': True},
        }

class InboxTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Inbox_Tasks
        fields = [
            'id',
            'title',
            'description',
            'user',
            'status',
            'priority',
        ]
        extra_kwargs = {
            'id': {'read_only':True},
        }        

class UpdateInboxTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Inbox_Tasks
        fields = [
            'id',
            'title',
            'description',
            'user',
            'status',
            'priority',
        ]
        extra_kwargs = {
            'id': {'read_only':True},
            'user': {'read_only':True},
        }  