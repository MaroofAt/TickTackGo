from django.shortcuts import render
from django.utils import timezone

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated


from drf_spectacular.utils import extend_schema

from .models import Task
from .serializers import TaskSerializer

from tools.roles_check import can_edit_project , is_creator ,is_project_owner


class TaskViewSet(viewsets.ModelViewSet):
    queryset = Task.objects.all()
    serializer_class = TaskSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return super().get_queryset()
    

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
        if not is_project_owner(request.user.id , request.data.get('project')):
            return Response({"detail": "User is not the owner or editor in this project"} , status=status.HTTP_400_BAD_REQUEST)
        
        if not can_edit_project(request.user.id , request.data.get('project')):
            return Response({"detail": "User is not the owner or editor in this project"} , status=status.HTTP_400_BAD_REQUEST)


        serializer = self.get_serializer(
            data = {
                'creator': request.user.id,
                'status': 'pending',
                **request.data
            }
        )
        if serializer.is_valid():
            serializer.save()
            ### check for the start time (we have to change it and do it in celery)
            tasks = Task.objects.filter(start_date__lte = timezone.now().date())
            for task in tasks:
                task.status = 'in_progress'
                task.save()
            ###            
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
        if not is_creator(request.user.id , pk):
            return Response({"detail": "User is not the creator of the task"} , status=status.HTTP_400_BAD_REQUEST)
        task = Task.objects.filter(pk = pk)
        if not task.exists():
            return Response({"detail": "Task already not existe"} , status=status.HTTP_404_NOT_FOUND)
        task = task.first()

        if not is_project_owner(request.user.id , task.project):
            return Response({"detail": "User is not the Owner of the workspace"} , status=status.HTTP_400_BAD_REQUEST)

        task.delete()
        return Response({'detail': 'Task Deleted'} , status=status.HTTP_200_OK)
    

    @extend_schema(
        summary="Mark The task Completed ",
        operation_id="mark_as_completed",
        description="Owner Edite any task status from in_progress to completed just | editor and viewer can edit the status of Their tasks only and from in_progress to completed just ",
        tags=["Tasks"]
    )
    @action(detail=False , methods=['post'] , serializer_class = TaskSerializer)
    def mark_as_completed(self , request , pk):
        task = Task.objects.filter(pk=pk)
        if not task.exists():
            return Response({"detail": "Task existe"} , status=status.HTTP_404_NOT_FOUND)
        task = task.first()
        if task.status == 'in_progress':
            if is_project_owner(request.user.id , task.project) or is_creator(request.user.id , pk) :
               task.status = 'completed' 
               return Response({'detail': 'Task Completed :) '} , status=status.HTTP_200_OK)
        
        return Response({'detail': 'Task can\'t be Completed '} , status=status.HTTP_200_OK)

            
