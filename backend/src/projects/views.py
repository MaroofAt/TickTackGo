from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated

from drf_spectacular.utils import extend_schema , OpenApiParameter , OpenApiExample

from workspaces.permissions import IsWorkspaceMember, IsWorkspaceOwner
from projects.permissions import IsProjectWorkspaceMember , IsProjectWorkspaceOwner , IsProjectMember

from users.models import User

from tools.responses import exception_response , required_response , method_not_allowed
from tools.roles_check import is_project_workspace_member , is_project_member

from .models import Project, Project_Membership , Issue ,Issue_Replies
from .serializers import ProjectSerializer , ProjectMembershipSerializer , IssueSerializer , ShowIssueSerializer,  IssueRepliesSerializer

# Create your views here.
class ProjectViewSet(viewsets.ModelViewSet):
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer

    
    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action == 'list':
            self.permission_classes.append(IsWorkspaceMember)
        if self.action == 'retrieve' or self.action == 'destroy':
            self.permission_classes.append(IsProjectWorkspaceMember)
        if self.action == 'change_user_role' or self.action == 'add_user_to_project':
            self.permission_classes.append(IsProjectWorkspaceOwner)
        if self.action == 'create':
            self.permission_classes.append(IsWorkspaceOwner)
        return super().get_permissions()
    def get_queryset(self):
        qs = super().get_queryset()
        if self.action == 'list':
            if self.request.data.get('workspace'):
                qs = qs.filter(workspace=self.request.data.get('workspace'))
            elif self.request.GET['workspace']:
                qs = qs.filter(workspace=self.request.GET['workspace'])
            else:
                raise Exception('must pass workspace id as query param !')
        return qs
    def get_serializer_context(self):
        """
        if self.action == 'retrieve':
            return {
                
            }.update(super().get_serializer_context())
        """
        return super().get_serializer_context()
        
    

    @extend_schema(
        summary="List Projects",
        operation_id="list_projects",
        description="Listing Authenticated User Project",
        tags=["Projects"],
        parameters=[
            OpenApiParameter(
                name='workspace',
                type=int,
                description='workspace id that u wants to get its projects (authenticated user must be a member of this workspace)',
                required=True
            )
        ]
    )
    def list(self, request, *args, **kwargs):
        try:
            if (not request.data.get('workspace')) and (not request.GET['workspace']): # for the permission to work
                return required_response('Workspace ID')
            return super().list(request, *args, **kwargs)
        except Exception as e:
            return exception_response(e)
    
    @extend_schema(
        summary="Retrieve Projects",
        operation_id="retrieve_projects",
        description="Retrieve Project (the authenticated user must be a workspace member) ",
        tags=["Projects"],
    )
    def retrieve(self, request, *args, **kwargs):
        return super().retrieve(request, *args, **kwargs)
    
    @extend_schema(
        summary="Create Project",
        operation_id="create_project",
        description="Creating new project inside the workspace",
        tags=["Projects"],
        request={
            'application/json':{
                'type': 'object',
                'properties':{
                    'title': {'type':'string' , 'example':'Project 1'},
                    'color': {'type':'string' , 'example':'#ff0000'},
                    'workspace': {'type':'integer' , 'example':1},
                    'parent_project': {'type':'integer' , 'example':1},
                },
                'required':['title','workspace']
            }
        }
    )
    def create(self, request, *args, **kwargs):
        print(f'\n\nrequest.data = {request.data}\n\n')
        if not request.data.get('title'):
            return required_response('title')
        if not request.data.get('workspace'):
            return required_response('workspace')
        return super().create(request, *args, **kwargs)
    
    @extend_schema(
        summary="Delete Project",
        operation_id="delete_project",
        description="Deleting the specified project",
        tags=["Projects"],
    )
    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)
    
    @extend_schema(
        summary="Change User Role In Project",
        operation_id="change_user_role",
        description="Changing the user Role in the specified Project",
        tags=["Projects"],
        request={
            'application/json':{
                'type': 'object',
                'properties':{
                    'user': {'type':'integer' , 'example':1 , 'description': 'the user u want to change his role in this project'},
                    'role': {'type':'string' , 'example':'editor' , 'description': 'the new role, it is an enum [editor/viewer]'}
                },
                'required':['user', 'role']
            }
        },
        responses={202: ProjectMembershipSerializer(context={'add_member':True, 'extend_member':True, 'add_project':True})}
    )
    @action(detail=True, methods=['patch'], serializer_class=ProjectMembershipSerializer)
    def change_user_role(self, request, pk):
        # try:
            if not request.data.get('user'):
                return required_response('user')
            if request.data.get('user') == request.user:
                return Response(
                    {'detail': 'User Can\'t Change His Own Role From OWNER To Anything Else !!!'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            if not request.data.get('role'):
                return required_response('role')
            if request.data.get('role') == 'owner':
                return Response(
                    {'detail': 'Can\'t Change The User Role To OWNER !!!'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            if not User.objects.filter(id=request.data.get('user')).exists():
                return Response(
                    {'detail': 'User Not Found'},
                    status=status.HTTP_404_NOT_FOUND
                )
            
            # get the user object
            user = User.objects.filter(id=request.data.get('user'))
            if not user.exists():
                return Response(
                    {'detail': 'user does not exist!'},
                    status=status.HTTP_404_NOT_FOUND
                )
            user = user.first()
            
            # get the project membership
            project_membership = Project_Membership.objects.filter(member=user, project_id=pk)
            if not project_membership.exists():
                return Response(
                    {'detail': 'the user specified is not a member of this project'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            project_membership = project_membership.first()

            # update role using serializer
            serializer = self.get_serializer(
                instance=project_membership,
                data={'role': request.data.get('role')},
                partial=True,
                context={
                    'add_member':True,
                    'extend_member':True,
                    'add_project':True,
                }
            )
            serializer.is_valid(raise_exception=True)
            self.perform_update(serializer)
            return Response(
                serializer.data,
                status=status.HTTP_202_ACCEPTED
            )
        # except Exception as e:
        #     return exception_response(e)

    @extend_schema(
        summary="Add User To Project",
        operation_id="add_user_to_project",
        description="Adding user as member of the specified Project",
        tags=["Projects"],
        request={
            'application/json':{
                'type': 'object',
                'properties':{
                    'user': {'type':'integer' , 'example':1 , 'description': 'the user must be a workspace member'},
                },
                'required':['user']
            }
        },
        responses={202: ProjectMembershipSerializer(context={'add_member':True, 'extend_member':False, 'add_project':True})}
    )
    @action(detail=True, methods=['post'], serializer_class=ProjectMembershipSerializer)
    def add_user_to_project(self, request, pk):
        try:
            if not request.data.get('user'):
                return required_response('user')
            if request.data.get('user') == request.user:
                return Response(
                    {'detail': 'User Can\'t Add Himself To The Project (He Will Be a Member Twice!) !!!'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            if not is_project_workspace_member(user_id=request.data.get('user'), project_id=pk):
                return Response(
                    {'detail': 'User u Want To Add To This Project Must Be A Workspace Member Before!'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            if is_project_member(user_id=request.data.get('user'), project_id=pk):
                return Response(
                    {'detail': 'User Already A Member Of This Project'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            # serializer
            serializer = self.get_serializer(
                data={
                    "member":request.data.get('user'),
                    "project":pk
                },
                context={
                    "add_member":True,
                    "add_project":True,
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










    # Update
    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().update(request, *args, **kwargs)
    
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().partial_update(request, *args, **kwargs)



class IssueViewSet(viewsets.ModelViewSet):
    queryset = Issue.objects.all()
    serializer_class = IssueSerializer

    
    def get_permissions(self):
        self.permission_classes = [IsAuthenticated]
        if self.action == 'list':
            self.permission_classes.append(IsProjectMember)
        if self.action == 'retrieve':
            self.permission_classes.append(IsProjectWorkspaceMember)
        if self.action == 'create':
            self.permission_classes.append(IsProjectMember)
        return super().get_permissions()
    
    def get_serializer_class(self):
        if self.action == 'list' or self.action == 'retrieve':
            return ShowIssueSerializer
        return super().get_serializer_class()

    @extend_schema(
        summary = "Create Issue",
        operation_id = "create_issue",
        description="Create issue for task or project",
        tags=["Projects/Issue"],
        request={
            'application/json':{
                'type': 'object',
                'properties':{
                    'title': {'type':'string' , 'example':"New Issue" },
                    'desctiption': {'type':'string' , 'example':"description for the new issue" },
                    'project': {'type':'integar' , 'example':1 },

                },
                'required':['project' , 'title' , 'description']
            }
        },
    )
    def create(self , request , *args, **kwargs):
        if not request.data.get('title'):
            return required_response('title')
        if not request.data.get('description'):
            return required_response('description')
        if not request.data.get('project'):
            return required_response('project')
        # print (request.user)
        data = request.data.copy()
        data['user'] = request.user.id
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    @extend_schema(
        summary="List Issue",
        operation_id="list_issue",
        description="List the issue in the project",
        tags=['Projects/Issue']
    )
    def list(self, request, *args, **kwargs):

        if not request.data.get('project'):
            return Response(
                {"error": "Project ID is required in request data"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        if not is_project_workspace_member(request.user.id, request.data.get('project')):
            return Response(
                {"error": "You are not a member of this project"},
                status=status.HTTP_403_FORBIDDEN
            )
        
        issues = Issue.objects.filter(project=request.data.get('project'))
        serializer = self.get_serializer(issues, many=True)
        
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    @extend_schema(
        summary="Retrieve Issue",
        operation_id="retrieve_issue",
        description="Retrieve the issue in the project",
        tags=['Projects/Issue']
    )
    def retrieve(self, request, *args, **kwargs):
        pk = kwargs.get('pk')
        if not request.data.get('project'):
            return Response(
                {"error": "Project ID is required in request data"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        if not is_project_workspace_member(request.user.id, request.data.get('project')):
            return Response(
                {"error": "You are not a member of this project"},
                status=status.HTTP_403_FORBIDDEN
            )
        
        issues = Issue.objects.filter(project=request.data.get('project') , pk=pk)
        serializer = self.get_serializer(issues, many=True)
        
        return Response(serializer.data, status=status.HTTP_200_OK)
    

    @extend_schema(exclude=True)
    def update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().update(request, *args, **kwargs)
    
    @extend_schema(exclude=True)
    def destroy(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().destroy(request, *args, **kwargs)
    @extend_schema(exclude=True)
    def partial_update(self, request, *args, **kwargs):
        return method_not_allowed()
        return super().partial_update(request, *args, **kwargs)