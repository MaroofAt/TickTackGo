from django.db import transaction
from rest_framework import serializers



from .models import Task, Assignee, Comment ,  Inbox_Tasks, Task_Dependencies
from tools.dependencie_functions import creates_problems, can_start

from users.models import User


class TaskSerializer(serializers.ModelSerializer):
    assignees = serializers.PrimaryKeyRelatedField(read_only=False,many=True, queryset=User.objects.all())
    status_message = serializers.SerializerMethodField(read_only=True)
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
            'reminder',
            'status_message',
        ]
        extra_kwargs = {
            'id': {'read_only':True},
            'complete_date': {'read_only': True},
            'out_dated': {'read_only': True},
            'assignees': {'read_only': False}
        }

    def get_status_message(self, obj):
        if can_start(obj.pk):
            return ""
        return "Task can't start... it depends on another task."
    
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
        


class CreateCommentSerializer(serializers.ModelSerializer):
        class Meta:
            model= Comment
            fields= [
                'task',
                'user',
                'body',
                'created_at',
                'updated_at',
            ]


class CommentSerializer(serializers.ModelSerializer):
    class UserInnerSerialiser(serializers.ModelSerializer):
        class Meta:
            model = User
            fields = [
                'id',
                'username',
            ]
    user = UserInnerSerialiser()
    class Meta:
        model= Comment
        fields= [
            'id',
            'task',
            'user',
            'body',
            'created_at',
            'updated_at',
        ]

        
class TaskDependenciesSerializers(serializers.ModelSerializer):
    class Meta:
        model = Task_Dependencies
        fields = (
            'id',   'condition_task', 'target_task', 'type',
        )
        extra_kwargs = {
            'id': {'read_only':True},
        }
    def create(self, validated_data):
        if validated_data['target_task'] == validated_data['condition_task']:
            raise serializers.ValidationError({
                "you can't tie a task to it self!"
            })
        if validated_data['target_task'].project != validated_data['condition_task'].project:
            raise serializers.ValidationError({
                "you can't tie tasks from different projects!"
            })
        if creates_problems(validated_data):
            raise serializers.ValidationError({
                "this type of dependencie will create a scheduling impossibility."
            })
        
        print(validated_data['target_task'].project.workspace)
        return super().create(validated_data)

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


