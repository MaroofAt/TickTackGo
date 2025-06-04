

def fetch_project_id(request, view, class_name, fetch_from_pk=False):
    project_id = None
    if fetch_from_pk:
        project_id = view.kwargs.get('pk')
    if not project_id:
        project_id = request.data.get('project')
    if not project_id:
        try:
            project_id = request.GET['project']
        except Exception as e:
            project_id = view.kwargs.get('project_id')
    if not project_id: # for debugging
        raise Exception(f'can\'t fetch project id from request or view in permissions.py in {class_name}')
    return project_id

def fetch_workspace_id(request, view, class_name, fetch_from_pk=False):
    workspace_id = None
    if fetch_from_pk:
        workspace_id = view.kwargs.get('pk')
    if not workspace_id:
        workspace_id = request.data.get('workspace')
    if not workspace_id:
        try:
            workspace_id = request.GET['workspace']
        except Exception as e:
            workspace_id = view.kwargs.get('workspace_id')
    if not workspace_id: # for debugging
        raise Exception(f'can\'t fetch workspace id from request or view in permissions.py in {class_name}')
    return workspace_id