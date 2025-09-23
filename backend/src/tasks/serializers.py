from django.db import transaction
from django.conf import settings

from rest_framework import serializers



from .models import Task, Assignee, Comment ,  Inbox_Tasks, Task_Dependencies , Attachment
from tools.dependencie_functions import creates_problems, can_start

from users.models import User


class TaskSerializer(serializers.ModelSerializer):
    # assignees = serializers.PrimaryKeyRelatedField(read_only=False,many=True, queryset=User.objects.all())
    assignees = serializers.PrimaryKeyRelatedField(
        many=True,
        write_only=True,
        queryset=User.objects.all(),
        required=False
    )
    assignees_display = serializers.SlugRelatedField(
        many=True,
        read_only=True,
        source = 'assignees',
        slug_field='username'
    )
    parent_task = serializers.PrimaryKeyRelatedField(queryset=Task.objects.all() , required=False)
    status_message = serializers.SerializerMethodField(read_only=True)
    class AttachmentSerializer(serializers.ModelSerializer):
        class Meta:
            model = Attachment
            fields = [
                'id',
                'file',
                'created_at',
                'updated_at'
            ]
            extra_kwargs = {
                'id': {'read_only':True},
                'file': {'read_only':True},
                'created_at': {'read_only':True},
                'updated_at': {'read_only':True}
            }
    attachments_display = AttachmentSerializer(read_only=True , many=True , source='attachments')
    attachments = serializers.ListField(
        child = serializers.FileField(max_length=settings.MAX_FILE_SIZE, allow_empty_file=False, use_url=False),
        required=False,
        write_only=True
    )
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
            'assignees_display',
            'assignees',
            'status',
            'priority',
            'locked',
            'reminder',
            'status_message',
            'attachments',
            'attachments_display',
        ]
        extra_kwargs = {
            'id': {'read_only':True},
            'complete_date': {'read_only': True},
            'out_dated': {'read_only': True},
            'assignees': {'write_only': True},
            'assignees_display': {'read_only': True},
            'attachments': {'write_only': True},
            'attachments_display': {'read_only': True},
        }

    def __init__(self, instance=None, data=serializers.empty, **kwargs):
        print(f"\n\nin-serializer data = {data}\n\n")
        super().__init__(instance, data, **kwargs)


    def get_status_message(self, obj):
        if can_start(obj.pk):
            obj.locked = False
            obj.save()
            return ""
        
        obj.locked = True
        obj.save()
        return "Task can't start... it depends on another task."
    
    def create(self, validated_data):
        there_is_assignees = False
        there_is_attachments = False
        if 'assignees' in validated_data:
            assignees = validated_data.pop('assignees')
            there_is_assignees = True
        if 'attachments' in validated_data:
            attachments = validated_data.pop('attachments')
            there_is_attachments = True
            
        with transaction.atomic():
            # attachments & assignees save handling
            instance = super().create(validated_data)
            if there_is_assignees:
                for assignee in assignees:
                    if not Assignee.objects.filter(assignee=assignee,task_id=instance.id).exists():
                        Assignee.objects.create(
                            assignee=assignee,
                            task=instance
                        )
            if there_is_attachments:
                for attachment in attachments:
                    Attachment.objects.create(
                        file=attachment,
                        task=instance
                    )
        return instance
    
    def update(self, instance, validated_data): #TODO: Fix assignees handling + handle attachments update
        there_is_assignees = False
        there_is_attachments = False
        if 'assignees' in validated_data:
            assignees = validated_data.pop('assignees')
            there_is_assignees = True
        if 'attachments' in validated_data:
            attachments = validated_data.pop('attachments')
            there_is_attachments = True
        
        with transaction.atomic():
            # attachments & assignees update handling
            instance = super().update(instance=instance,validated_data=validated_data)
            if there_is_assignees:
                # deleting old task assignees
                old_assignees = Assignee.objects.filter(task_id=instance.id)
                for old_assignee in old_assignees:
                    old_assignee.delete()
                # creating the new ones
                for assignee in assignees:
                    Assignee.objects.create(
                        assignee=assignee,
                        task=instance
                    )
            if there_is_attachments:
                # deleting old task attachments
                old_attachments = Attachment.objects.filter(task=instance)
                for old_attachment in old_attachments:
                    old_attachment.delete()
                # creating the new ones
                for attachment in attachments:
                    Attachment.objects.create(
                        file=attachment,
                        task=instance
                    )
        return instance
        

class SubTaskSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Task
        fields = [
            'id', 'title', 'description', 'start_date', 'due_date', 
            'complete_date', 'status', 'priority', 'locked', 'reminder',
            'out_dated', 'image'
        ]
        read_only_fields = ['id']
class ShowTaskSerializer(serializers.ModelSerializer):
    sub_tasks = SubTaskSerializer(many=True, read_only=True)
    #assignees = serializers.PrimaryKeyRelatedField(read_only=False,many=True, queryset=User.objects.all())
    assignees = serializers.SlugRelatedField(
        many=True,
        read_only=False,
        queryset=User.objects.all(),
        slug_field='username'
    )
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
            'sub_tasks',
            'status_message'
        ]
        extra_kwargs = {
            'id': {'read_only':True},
            'complete_date': {'read_only': True},
            'out_dated': {'read_only': True},
            'assignees': {'read_only': True},
            'sub_tasks': {'read_only': True},
        }

    def get_status_message(self, obj):
        if can_start(obj.pk):
            obj.locked = False
            obj.save()
            return ""
        
        obj.locked = True
        obj.save()
        return "Task can't start... it depends on another task."
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


