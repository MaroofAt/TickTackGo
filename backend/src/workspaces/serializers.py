from rest_framework import serializers
from django.conf import settings
from django.db import transaction

from .models import Workspace , Workspace_Membership
from users.models import User


class LocalUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'username',
            'email',
            'image',
            'how_to_use_website',
            'what_do_you_do',
            'how_did_you_get_here',
            'created_at',
            'updated_at',
        ]

class WorkspaceMembershipSerializer(serializers.ModelSerializer):
    member = serializers.PrimaryKeyRelatedField(read_only=True)
    workspace = serializers.PrimaryKeyRelatedField(read_only=True)
    class Meta:
        model = Workspace_Membership
        fields = [
            'member',
            'workspace',
            'role',
            'created_at',
            'updated_at',
        ]
    
    def __init__(self, instance=None, data=serializers.empty, **kwargs):
        super().__init__(instance, data, **kwargs)
        
        if not self.context.get('add_member' , False):
            self.fields.pop('member')
        if self.context.get('extend_member' , False):
            self.fields['member'] = LocalUserSerializer(read_only=True)
        
        if not self.context.get('add_workspace' , False):
            self.fields.pop('workspace')
        if self.context.get('extend_workspace' , False):
            self.fields['workspace'] = WorkspaceSerializer(read_only=True)

class WorkspaceSerializer(serializers.ModelSerializer):
    owner = LocalUserSerializer(read_only=True)
    members = serializers.SerializerMethodField()
    class Meta:
        model = Workspace
        fields = [
            'title',
            'description',
            'image',
            'owner',
            'members',
            'code',
            'created_at',
            'updated_at',
        ]
        extra_kwargs = {
            'image': {
                'required': False
            },
            'description': {
                'required': False
            }
        }

    def get_members(self,obj):
        non_owner_memberships = obj.workspace_members.exclude(role='owner')
        return WorkspaceMembershipSerializer(
            non_owner_memberships,
            many=True,
            source='workspace_members',
            context={
                'add_member': True,
                'extend_member': True,
                'add_workspace': False,
                'extend_workspace': False
                },
                read_only=True
            ).data

    def create(self, validated_data):
        try:
            owner = self.context['request'].user
            owner_workspaces = Workspace.objects.filter(owner_id=owner.id)
            if (len(owner_workspaces) >= settings.MAX_WORKSPACES_COUNT_FOR_SINGLE_USER):
                raise serializers.ValidationError(f'User {str(owner)} has reached the allowed limit of workspaces count !')
            with transaction.atomic():
                if not ('description' in validated_data):
                    validated_data['description'] = ""
                if 'image' in validated_data:
                    image = validated_data.pop('image')
                validated_data['owner'] = owner
                instance = super().create(validated_data)
                if 'image' in validated_data:
                    instance.image = image
                    instance.save()
                Workspace_Membership.objects.create(
                    member = owner,
                    workspace = instance,
                    role = 'owner'
                )
            return instance
        except Exception as e:
            raise e
