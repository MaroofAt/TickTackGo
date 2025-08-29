from django.shortcuts import render
from django.utils import timezone

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated


from drf_spectacular.utils import extend_schema, OpenApiParameter, OpenApiExample



from .models import Task, Comment , Inbox_Tasks, Task_Dependencies
from .serializers import TaskSerializer, CommentSerializer , InboxTaskSerializer , UpdateInboxTaskSerializer, TaskDependenciesSerializers , CreateCommentSerializer , ShowTaskSerializer


from .permissions import IsTaskProjectMember, IsTaskProjectOwner , IsEditableTask


from projects.permissions import IsProjectMember
from workspaces.models import Points , Workspace
from users.models import User

from tools.roles_check import can_edit_project , is_creator ,is_project_owner , is_task_project_owner
from tools.responses import method_not_allowed, exception_response, required_response
from tools.dependencie_functions import can_end, can_start
from tools.points import calculate_task_points
from tools.notify import send




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
        if self.action == 'list':
            self.permission_classes.append(IsProjectMember)
        if self.action == 'retrieve' or self.action == 'create_comment' or self.action == 'list_comment':
            self.permission_classes.append(IsTaskProjectMember)
        if self.action == 'assign_task_to_user':
            self.permission_classes.append(IsTaskProjectOwner)
        if self.action == 'update':
            self.permission_classes.append(IsEditableTask)
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
            },
            'application/json': {
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
                }
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
        data = request.data.copy()
        data.update({
            'creator': request.user.id,
            'status': 'pending'  
        })

        serializer = self.get_serializer(data=data)
        # serializer = self.get_serializer(
        #     data = {
        #         'creator': request.user.id,
        #         'status': 'pending',
        #         **request.data
        #     }
        # )

        user = User.objects.filter(id=request.user.id).first()
        worksapce = Workspace.objects.filter(id=request.data.get('workspace')).first()
        result = send(request.data.get('assignees') , 'Task added' , f'{user.username} assigne new task to you in {worksapce.title}')
        if serializer.is_valid():
            serializer.save()
         
            return Response({
                'data': serializer.data,
                'result': result
            }, status=status.HTTP_201_CREATED)
        

        return Response({
            'errors': serializer.errors,
            'result': result
        }, status=status.HTTP_400_BAD_REQUEST)

    @extend_schema(
        summary="Cancel Task",
        operation_id="cancel_task",
        description="Owner or can_edite who is the creator of the task can can cancel task ",
        tags=["Tasks"]
    )
    @action(detail=True , methods=['get'] , serializer_class = TaskSerializer)
    def cancel(self,request , pk):
        # if not is_creator(request.user.id , pk) :
        #     return Response({"detail": "User is not the creator of the task"} , status=status.HTTP_400_BAD_REQUEST)

        task = Task.objects.filter(pk = pk)
        if not task.exists():
            return Response({"detail": "Task already not existe"} , status=status.HTTP_404_NOT_FOUND)
        task = task.first()

        # if not is_project_owner(request.user.id , task.project):
        #     return Response({"detail": "User is not the Owner of the workspace"} , status=status.HTTP_400_BAD_REQUEST)


        if is_project_owner(request.user.id , task.project) or is_creator(request.user.id , pk) :
            task.delete()
            return Response({'detail': 'Task Deleted'} , status=status.HTTP_200_OK)
        
        return Response({"detail": "User is not the Owner of the workspace or not the Creator of the Task"} , status=status.HTTP_400_BAD_REQUEST)

    @extend_schema(
        summary="Mark The task Completed ",
        operation_id="mark_as_completed",
        description="Owner Edite any task status from in_progress to completed just | editor and viewer can edit the status of Their tasks only and from in_progress to completed just ",
        tags=["Tasks"]
    )
    @action(detail=True , methods=['get'] , serializer_class = TaskSerializer)
    def mark_as_completed(self , request , pk):
        try:
            # ### check for the start time (we have to change it and do it in celery)
            # tasks = Task.objects.filter(start_date__lte = timezone.now().date())
            # for task in tasks:
            #     if task.status == 'pending':
            #         task.status = 'in_progress'
            #         task.save()
            # ###        
            task = Task.objects.filter(pk=pk)
            if not task.exists():
                return Response({"detail": "Task exist"} , status=status.HTTP_404_NOT_FOUND)
            task = task.first()
            if task.status == 'in_progress':
                if not can_end(task.id):
                    return Response({'detail': 'Task can\'t be Completed... it depends on another task. '} , status=status.HTTP_400_BAD_REQUEST)
                if is_project_owner(request.user.id , task.project) or is_creator(request.user.id , pk) :
                    task.status = 'completed' 
                    task.complete_date = timezone.now().date()
                    task.done_assignee = request.user
                    task.save()
                    # Points ###############################################################################################
                    task_points = calculate_task_points(task)
                    task_assignees = task.assignees
                    task_workspace = task.project.workspace
                    for assignee in task_assignees.all():
                        points_object = Points.objects.filter(user=assignee,workspace=task_workspace).first()
                        points_object.total += task_points.get('total')
                        points_object.hard_worker += task_points.get('hard_work_points')
                        points_object.important_mission_solver += task_points.get('important_mission_points')
                        points_object.discipline_member += task_points.get('discipline_points')
                        points_object.save()
                    ########################################################################################################
                    return Response({'detail': 'Task Completed :) '} , status=status.HTTP_200_OK)
            
            return Response({'detail': 'Task can\'t be Completed '} , status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return exception_response(e)

            
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
            # queryset = self.filter_queryset(self.get_queryset())

            # for task in queryset:
            #     if can_start(task.pk) and task.status == 'pending':
            #         task.change_status_when_start()

            # serializer = self.get_serializer(queryset, many=True)
            # return Response(serializer.data)
            queryset = Task.objects.filter(parent_task__isnull=True)
            serializer = ShowTaskSerializer(queryset, many=True)
            return Response(serializer.data , status.HTTP_200_OK)
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
    
    @extend_schema(
        summary="Assign Task To User",
        operation_id="assign_task_to_user",
        description="Assigning Task To User Or Multiple Users",
        tags=["Tasks"],
        request={
            "application/json":{
                'type': 'object',
                "properties":{
                    "assignees":{"type":"[integer]", "example":"[1,2,3,4]"}
                },
                "required": ["assignees"]
            }
        }
    )
    @action(detail=True, methods=['patch'])
    def assign_task_to_user(self, request, pk):
        try:
            a = {**request.data}
            print(f"\n\n{a}\n\n")
            if not request.data.get('assignees'):
                return required_response('assignees')
            # Get The Task
            task = Task.objects.filter(id=pk)
            if not task.exists():
                return False
            task = task.first()

            serializer = self.get_serializer(
                instance = task,
                data= {
                    **request.data,
                    "title":task.title,
                    "creator":task.creator.pk,
                    "workspace":task.workspace.pk,
                    "project":task.project.pk
                }
            )
            serializer.is_valid(raise_exception=True)
            self.perform_update(serializer)
            return Response(
                serializer.data,
                status=status.HTTP_202_ACCEPTED
            )
        except Exception as e:
            return exception_response(e)


    @extend_schema(
        summary="Cancel Tasks",
        operation_id="cancel_task",
        description="Cancel Specified Task",
        tags=["Tasks"]
    )
    @action(detail=True , methods=['get'] , serializer_class = TaskSerializer)
    def cancel_task(self , request , pk):
        task = Task.objects.filter(pk=pk).first()
        if is_task_project_owner(request.user.id , pk ) or is_creator(request.user.id , pk):
            self.perform_destroy(instance=task)
            return Response(None , status.HTTP_200_OK)
        return Response({"message":"You are not the owner or the creator of the task"} , status.HTTP_400_BAD_REQUEST)


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
    
    ## Comments Section

    @extend_schema(
        summary="Create Comment",
        operation_id="create_comment",
        description="Creating A Comment On The Specified Task",
        tags=["Tasks/Comments"],
        request={
            "application/json":{
                'type': 'object',
                "properties":{
                    "body":{"type":"string", "example":"Can u provide me with the progress u made on this task till now?"}
                },
                "required": ["body"]
            }
        }
    )
    @action(detail=True, methods=['post'], serializer_class=CreateCommentSerializer)
    def create_comment(self, request, pk):
        try:
            if not request.data.get('body'):
                return required_response('body')
            serializer = self.get_serializer(
                data={
                    **request.data,
                    "user": request.user.pk,
                    "task": pk
                }
            )
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        except Exception as e:
            return exception_response(e)
        
    @extend_schema(
        summary="List Comments",
        operation_id="list_comments",
        description="Listing Comments On The Specified Task",
        tags=["Tasks/Comments"],
    )
    @action(detail=True, methods=['get'], serializer_class=CommentSerializer)
    def list_comments(self, request, pk):
        try:
            task = Task.objects.filter(id=pk)
            if not task.exists():
                return False
            task = task.first()

            comments = Comment.objects.filter(task=pk)

            serializer = self.get_serializer(instance=comments, many=True)
            return Response(
                serializer.data,
                status=status.HTTP_200_OK
            )
        except Exception as e:
            return exception_response(e)
    

class InboxTaskViewSet(viewsets.ModelViewSet):
    queryset = Inbox_Tasks.objects.all()
    serializer_class = InboxTaskSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        qs = super().get_queryset()
        if self.action == 'list':
            qs = qs.filter(user=self.request.user)
            if not self.request.GET.get('pending', True):
                qs = qs.exclude(status='pending')
            if not self.request.GET.get('in_progress', True):
                qs = qs.exclude(status='in_progress')
            if not self.request.GET.get('completed', True):
                qs = qs.exclude(status='completed')
        return qs
    
    @extend_schema(
        summary="Retrieve Inbox Tasks",
        operation_id="retrieve_inbox_tasks",
        description="Retrieving Specified Inbox Task",
        tags=["Inbox_Tasks"]
    )
    def retrieve(self, request,pk, *args, **kwargs ):
        try:
            inbox_task = Inbox_Tasks.objects.filter(user=request.user, pk=pk).first()
            
            if not inbox_task:
                return Response(
                    {"detail": "Not found."},
                    status=status.HTTP_404_NOT_FOUND
                )
            
            serializer = self.get_serializer(inbox_task)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            return exception_response(e)

    @extend_schema(
        summary="List Inbox Tasks",
        operation_id="list_Inbox_tasks",
        description="Listing All Inbox Tasks",
        tags=["Inbox_Tasks"],
        # parameters=[
        #     OpenApiParameter(
        #         name='pending',
        #         type=bool,
        #         required=False,
        #         description='Do you want to show the pending tasks?',
        #         default=True
        #     ),
        #     OpenApiParameter(
        #         name='in_progress',
        #         type=bool,
        #         required=False,
        #         description='Do you want to show the in_progress tasks?',
        #         default=True
        #     ),
        #     OpenApiParameter(
        #         name='completed',
        #         type=bool,
        #         required=False,
        #         description='Do you want to show the completed tasks?',
        #         default=True
        #     ),
        # ]
    )
    def list(self, request, *args, **kwargs):
        try:
            return super().list(request, *args, **kwargs)
        except Exception as e:
            return exception_response(e)
    
    @extend_schema(
        summary="Create Inbox Tasks",
        operation_id="create_inbox_tasks",
        description="Create Inbox Task",
        tags=["Inbox_Tasks"],
        request={
            'multipart/form-data': {
                'type': 'object',
                'properties': {
                    'title': {'type': 'string', 'example': 'Task 1'},
                    'description': {'type': 'string', 'example': 'ABU Alish AMAK'},
                    'status': {'type':'string' , 'example':'pending' or 'in_progress' or 'completed'},
                    'priority': {'type':'string' , 'example':'high' or 'medium' or 'low'}
                },
                # 'required': ['title']
            }
        }
    )
    def create(self, request):

        data = request.data.copy()
        data.update({
            'user': request.user.id,
        })
        serializer = self.get_serializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status=status.HTTP_201_CREATED)
        
        return Response(serializer.errors , status=status.HTTP_400_BAD_REQUEST)

    @extend_schema(
        summary="Destroy Inbox Tasks",
        operation_id="destroy_inbox_tasks",
        description="Destroying Specified Inbox Task",
        tags=["Inbox_Tasks"]
    )
    def destroy(self, request, *args, **kwargs):
        try:
            pk = kwargs.get('pk')
            inbox_task = Inbox_Tasks.objects.filter(user=request.user, pk=pk).first()
            
            if not inbox_task:
                return Response(
                    {"detail": "Not found."},
                    status=status.HTTP_404_NOT_FOUND
                )
            
            # serializer = self.get_serializer(inbox_task)
            inbox_task.delete()
            return Response({"detail": "Done :) "}, status=status.HTTP_200_OK)
        except Exception as e:
            return exception_response(e)
        
    
    @extend_schema(
        summary="Update Inbox Tasks",
        operation_id="update_inbox_tasks",
        description="Updating Specified Inbox Task",
        tags=["Inbox_Tasks"]
    )
    def update(self, request, *args, **kwargs):
        # print('Aliiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii')
        # try:
            pk = kwargs.get('pk')
            self.serializer_class = UpdateInboxTaskSerializer
            inbox_task = Inbox_Tasks.objects.filter(user=request.user, pk=pk).first()
            
            if not inbox_task:
                return Response(
                    {"detail": "Not found."},
                    status=status.HTTP_404_NOT_FOUND
                )
            return super().update(request, *args, **kwargs)
        # except Exception as e:
        #     return exception_response(e)

    @extend_schema(
        summary="Partial Update Inbox Tasks",
        operation_id="partial_update_inbox_tasks",
        description="Partial Updating Specified Inbox Task",
        tags=["Inbox_Tasks"]
    )

    def partial_update(self, request, *args, **kwargs):
        pk = kwargs.get('pk')
        self.serializer_class = UpdateInboxTaskSerializer
        inbox_task = Inbox_Tasks.objects.filter(user=request.user, pk=pk).first()
        
        if not inbox_task:
            return Response(
                {"detail": "Not found."},
                status=status.HTTP_404_NOT_FOUND
            )
        return super().partial_update(request, *args, **kwargs)
    

class TaskDependenciesViewSet(viewsets.ModelViewSet):
    queryset = Task_Dependencies.objects.all()
    serializer_class = TaskDependenciesSerializers
    permission_classes = [IsAuthenticated]


    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action in ['update', 'destroy']:
            self.permission_classes.append(IsTaskProjectOwner)
        return super().get_permissions()

    @extend_schema(
        summary="List all task dependencies",
        description="Retrieve a list of all task dependencies.",
        responses={200: TaskDependenciesSerializers(many=True)},
        tags=["Task_Dependencies"],
    )
    def list(self, request, *args, **kwargs):
        #self.permission_classes.append(IsTaskProjectOwner)
        return super().list(request, *args, **kwargs)

    @extend_schema(
        summary="Retrieve a specific task dependency",
        description="Get details of a single task dependency by its ID.",
        responses={200: TaskDependenciesSerializers},
        tags=["Task_Dependencies"],
    )
    def retrieve(self, request, *args, **kwargs):
        return super().retrieve(request, *args, **kwargs)

    @extend_schema(
        summary="Create a new task dependency",
        description=(
            "Create a new dependency between two tasks. \n\n"
            "- `target_task`: The task that depends on another. \n"
            "- `condition_task`: The task it depends on. \n"
            "- `type`: The dependency type "
            "(`start_to_start`, `start_to_finish`, `finish_to_start`, `finish_to_finish`)."
        ),
        request=TaskDependenciesSerializers,
        responses={201: TaskDependenciesSerializers},
        examples=[
            OpenApiExample(
                "Example dependency",
                value={
                    "condition_task": 1,
                    "target_task": 2,
                    "type": "finish_to_start",
                },
            ),
        ],
        tags=["Task_Dependencies"],
    )
    def create(self, request, *args, **kwargs):
        if not is_project_owner(request.user.id , request.data.get('condition_task').project):
            return Response({"detail": "User is not the owner or editor in this project"} , status=status.HTTP_400_BAD_REQUEST)
        return super().create(request, *args, **kwargs)

    @extend_schema(
        summary="Update a task dependency",
        description="Update the details of an existing dependency.",
        request=TaskDependenciesSerializers,
        responses={200: TaskDependenciesSerializers},
        tags=["Task_Dependencies"],
    )
    def update(self, request, *args, **kwargs):
        #self.permission_classes.append(IsTaskProjectOwner)
        return super().update(request, *args, **kwargs)

    @extend_schema(
        summary="Delete a task dependency",
        description="Remove a task dependency by its ID.",
        responses={204: None},
        tags=["Task_Dependencies"],
    )
    def destroy(self, request, *args, **kwargs):
        #self.permission_classes.append(IsTaskProjectOwner)
        return super().destroy(request, *args, **kwargs)