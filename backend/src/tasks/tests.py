from django.conf import settings
from rest_framework.test import APITestCase
from rest_framework import status

from users.models import User
from workspaces.models import Workspace , Workspace_Membership
from projects.models import Project , Project_Membership
from tasks.models import Task

# Create your tests here.
class UpdateTaskTestCase(APITestCase):
    def setUp(self):
        # Users
        self.owner = User.objects.create_user(
            username='w',
            email='w@w.com',
            password='12345678',
            how_to_use_website='own_tasks_management',
            what_do_you_do = 'software_or_it',
            how_did_you_get_here = 'google_search'
        )
        self.member = User.objects.create_user(
            username='x',
            email='x@x.com',
            password='12345678',
            how_to_use_website='own_tasks_management',
            what_do_you_do = 'software_or_it',
            how_did_you_get_here = 'google_search'
        )

        # workspace
        self.workspace = Workspace.objects.create(
            title='workspace title',
            description='description',
            owner=self.owner,
        )
        self.member_workspace_membership = Workspace_Membership.objects.create(
            member=self.member,
            workspace=self.workspace,
            role='member'
        )
        self.owner_workspace_membership = Workspace_Membership.objects.create(
            member=self.owner,
            workspace=self.workspace,
            role='owner'
        )

        # project
        self.project = Project.objects.create(
            title='Project Title',
            workspace=self.workspace,
        )
        self.owner_project_membership = Project_Membership.objects.create(
            member = self.owner,
            project = self.project,
            role = 'owner'
        )
        self.member_project_membership = Project_Membership.objects.create(
            member = self.member,
            project = self.project,
            role = 'editor'
        )

        # tasks
        self.owner_task = Task.objects.create(
            title='Owner Task Title',
            start_date='2025-9-26',
            due_date='2025-10-5',
            creator=self.owner,
            workspace=self.workspace,
            project=self.project,
            status='pending',
            priority='high',
        )
        self.member_task = Task.objects.create(
            title='Member Task Title',
            start_date='2025-10-16',
            due_date='2025-12-15',
            creator=self.member,
            workspace=self.workspace,
            project=self.project,
            status='pending',
            priority='high',
        )
        self.not_pending_owner_task = Task.objects.create(
            title='Not Pending Owner Task Title',
            start_date='2025-9-26',
            due_date='2025-10-5',
            creator=self.owner,
            workspace=self.workspace,
            project=self.project,
            status='completed',
            priority='high',
        )
        print(f'\n\nself.not_pending_owner_task.id: {self.not_pending_owner_task.id}\n\n')
        print(f'\n\nself.member_task.id: {self.member_task.id}\n\n')
        # URL
        self.owner_task_url = f'http://127.0.0.1:8000/api/tasks/{self.owner_task.id}/' #if settings.DEBUG else '' #TODO Domain
        self.member_task_url = f'http://127.0.0.1:8000/api/tasks/{self.member_task.id}/' #if settings.DEBUG else '' #TODO Domain
        self.not_pending_owner_task_url = f'http://127.0.0.1:8000/api/tasks/{self.not_pending_owner_task.id}/' #if settings.DEBUG else '' #TODO Domain
        print(f'\n\nself.not_pending_owner_task_url: {self.not_pending_owner_task_url}\n\n')

    
    def test_owner_updating_task(self):
        data = {
            'title': 'Updated Owner Task',
            'start_date': '2026-01-01',
            'due_date': '2026-02-02',
            'assignees': [
                self.owner.id,
                self.member.id
            ]
        }
        self.client.login(email='w@w.com', password='12345678')
        response = self.client.patch(self.owner_task_url, data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(response.data['title'] == data['title'])
        self.assertTrue(response.data['start_date'] == data['start_date'])
        self.assertTrue(response.data['due_date'] == data['due_date'])
    
    def test_member_updating_task_he_created(self):
        data = {
            'title': 'Updated Member Task',
            'start_date': '2026-01-01',
            'due_date': '2026-02-02',
            'assignees': [
                self.owner.id,
                self.member.id
            ]
        }
        self.client.login(email='x@x.com', password='12345678')
        response = self.client.patch(self.member_task_url, data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(response.data['title'] == data['title'])
        self.assertTrue(response.data['start_date'] == data['start_date'])
        self.assertTrue(response.data['due_date'] == data['due_date'])

    def test_member_updating_task_he_did_not_create(self):
        data = {
            'title': 'Updated Member Task',
            'start_date': '2026-01-01',
            'due_date': '2026-02-02',
            'assignees': [
                self.owner.id,
                self.member.id
            ]
        }
        self.client.login(email='x@x.com', password='12345678')
        response = self.client.patch(self.owner_task_url, data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
    def test_owner_updating_task_he_did_not_create(self):
        data = {
            'title': 'Updated Member Task',
            'start_date': '2026-01-01',
            'due_date': '2026-02-02',
            'assignees': [
                self.owner.id,
                self.member.id
            ]
        }
        self.client.login(email='w@w.com', password='12345678')
        response = self.client.patch(self.member_task_url, data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(response.data['title'] == data['title'])
        self.assertTrue(response.data['start_date'] == data['start_date'])
        self.assertTrue(response.data['due_date'] == data['due_date'])
    def test_owner_updating_not_pending_task(self):
        data = {
            'title': 'Updated Member Task',
            'start_date': '2026-01-01',
            'due_date': '2026-02-02',
            'assignees': [
                self.owner.id,
                self.member.id
            ]
        }
        self.client.login(email='w@w.com', password='12345678')
        response = self.client.patch(self.not_pending_owner_task_url, data)
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)    
    

