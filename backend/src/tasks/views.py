from django.shortcuts import render

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated


from drf_spectacular.utils import extend_schema, OpenApiParameter

from .models import Task
from .serializers import TaskSerializer
from .permissions import IsTaskProjectMember

from tools.roles_check import can_edit_project , is_creator
from tools.responses import method_not_allowed, exception_response


class TaskViewSet(viewsets.ModelViewSet):
    queryset = Task.objects.all()
    serializer_class = TaskSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        qs = super().get_queryset()
        if self.action == 'list':
            qs = qs.filter(project=self.request.GET['project'])
            if not self.request.GET.get('pending', True):
                qs = qs.exclude(status='pending')
            if not self.request.GET.get('in_progress', True):
                qs = qs.exclude(status='in_progress')
            if not self.request.GET.get('completed', True):
                qs = qs.exclude(status='completed')
        return qs
    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action == 'list' or self.action == 'retrieve':
            self.permission_classes.append(IsTaskProjectMember)
        return super().get_permissions()

    @extend_schema(
        summary="Create Task",
        operation_id="create_task",
        description="Owner or can_edite can create task ",
        tags=["Tasks"],
        request={
            'multipart/form-data': {
                'type': 'object',
                'properties': {
                    'title': {'type': 'string', 'example': 'Task 1'},
                    'description': {'type': 'string', 'example': 'ABU Alish AMAK'},
                    'start_date': {'type': 'Date', 'example': '6/6/2025'},
                    'due_date': {'type': 'Date', 'example': '9/6/2025'},
                    'workspace': {'type':'integer' , 'example':1},
                    'project': {'type':'integer' , 'example':1},
                    'perent_task': {'type':'integer' , 'example':1 or None},
                    'status': {'type':'string' , 'example':'pending' or 'in_progress' or 'completed'},
                    'priority': {'type':'string' , 'example':'high' or 'medium' or 'low'},
                    'locked': {'type':'boolean' , 'example':False},
                    'reminder': {'type': 'Date', 'example': '9/6/2025'},
                    'image': {'type': 'string' , 'format': 'binary'}
                },
                # 'required': ['title']
            }
        }
    )
    # @action(detail=True , methods=['post'] , serializer_class=TaskSerializer)
    def create(self, request, *args, **kwargs):
        # return super().create(request, *args, **kwargs)
        if not can_edit_project(request.user.id , request.data.get('project')):
            return Response({"detail": "User is not the owner or editor in this project"} , status=status.HTTP_400_BAD_REQUEST)
        serializer = self.get_serializer(
            data = {
                'creator': request.user.id,
                # 'status': 'pending',
                **request.data
            }
        )
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status=status.HTTP_201_CREATED)
        
        return Response(serializer.errors , status=status.HTTP_400_BAD_REQUEST)


    @extend_schema(
        summary="Cancel Task",
        operation_id="cancel_task",
        description="Owner or can_edite who is the creator of the task can can cancel task ",
        tags=["Tasks"]
    )
    @action(detail=False , methods=['post'] , serializer_class = TaskSerializer)
    def cancel(self,request , pk):
        # if maroof_method(request.user.id , )
        if is_creator(request.user.id , request.data.get('task')):
            return Response({"detail": "User is not the creator of the task"} , status=status.HTTP_400_BAD_REQUEST)
        task = Task.objects.filter(pk = pk)
        if not task.exists():
            return Response({"detail": "Task already not existe"} , status=status.HTTP_404_NOT_FOUND)
        task = task.first()
        task.delete()
        return Response({'detail': 'Task Deleted'} , status=status.HTTP_200_OK)
    
    @extend_schema(
        summary="List Tasks",
        operation_id="list_tasks",
        description="Listing All Tasks in the Project",
        tags=["Tasks"],
        parameters=[
            OpenApiParameter(
                name='project',
                type=int,
                required=True,
                description='project id that u wants to get its s (authenticated user must be a member of this project)'
            ),
            OpenApiParameter(
                name='pending',
                type=bool,
                required=False,
                description='Do you want to show the pending tasks?',
                default=True
            ),
            OpenApiParameter(
                name='in_progress',
                type=bool,
                required=False,
                description='Do you want to show the in_progress tasks?',
                default=True
            ),
            OpenApiParameter(
                name='completed',
                type=bool,
                required=False,
                description='Do you want to show the completed tasks?',
                default=True
            ),
        ]
    )
    def list(self, request, *args, **kwargs):
        try:
            return super().list(request, *args, **kwargs)
        except Exception as e:
            return exception_response(e)
    
    @extend_schema(
        summary="Retrieve Tasks",
        operation_id="retrieve_tasks",
        description="Retrieving Specified Task",
        tags=["Tasks"]
    )
    def retrieve(self, request, *args, **kwargs):
        try:
            return super().retrieve(request, *args, **kwargs)
        except Exception as e:
            return exception_response(e)
    
    
    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().partial_update(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def destroy(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().destroy(request, *args, **kwargs)