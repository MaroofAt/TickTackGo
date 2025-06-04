from django.db import transaction
from rest_framework import serializers

from workspaces.serializers import WorkspaceSerializer , LocalUserSerializer

from workspaces.models import Workspace
from users.models import User
from .models import Project , Project_Membership


class ProjectMembershipSerializer(serializers.ModelSerializer):
    member = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    project = serializers.PrimaryKeyRelatedField(queryset=Project.objects.all())
    class Meta:
        model = Project_Membership
        fields = [
            'member',
            'project',
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

        if not self.context.get('add_project' , False):
            self.fields.pop('project')
        if self.context.get('extend_project' , False):
            self.fields['project'] = ProjectSerializer(read_only=True)



class ProjectSerializer(serializers.ModelSerializer):
    
    workspace = serializers.PrimaryKeyRelatedField(queryset=Workspace.objects.all())
    parent_project = serializers.PrimaryKeyRelatedField(read_only=True)
    members = serializers.SerializerMethodField()
    class Meta:
        model=Project
        fields = [
            'id',
            'title',
            'color',
            'ended',
            'workspace',
            'parent_project',
            'members',
            'created_at',
            'updated_at',
        ]
        extra_kwargs= {
            'color': {
                'required': False
            },
            'parent_project': {
                'required': False
            },
            'ended': {
                'read_only': True,
                'required': False
            },
        }

    def get_members(self,obj):
        return ProjectMembershipSerializer(
            obj.memberships.all(),
            many=True,
            source='memberships',
            context={
                'add_member':True,
                'extend_member':True,
                'add_project':False,
                'extend_project':False,
            }
        ).data

    def __init__(self, instance=None, data=serializers.empty, **kwargs):
        super().__init__(instance, data, **kwargs)

        if self.context.get('extend_workspace' , False):
            self.fields['workspace'] = WorkspaceSerializer(read_only=True)
        if self.context.get('extend_parent_project' , False):
            self.fields['parent_project'] = ProjectSerializer(read_only=True)
        
        self.fields['workspace'].queryset = Workspace.objects.filter(owner=self.context['request'].user) # just workspaces that the user owns, so he can't assign to other workspaces
    

    def create(self, validated_data):
        print(f'\n\nvalidated_data = {validated_data}\n\n')
        with transaction.atomic():
            instance = super().create(validated_data)
            Project_Membership.objects.create(
                member = self.context['request'].user,
                project = instance,
                role = 'owner'
            )
        return instance