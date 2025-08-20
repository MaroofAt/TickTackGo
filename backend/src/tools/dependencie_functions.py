from tasks.models import Task_Dependencies
from django.core.exceptions import MultipleObjectsReturned, ObjectDoesNotExist

def can_start(task_id):
    task_dependencies = Task_Dependencies.objects.filter(
        target_task=task_id,
        type__in=['finish_to_start', 'start_to_start']
    )

    for task_dependencie in task_dependencies:
        task = task_dependencie.condition_task
        if (task_dependencie.type == 'start_to_start' and task.status == 'pending') or \
            (task_dependencie.type == 'finish_to_start' and task.status != 'completed'):
            return False

    return True


def can_end(task_id):
    task_dependencies = Task_Dependencies.objects.filter(
    target_task=task_id,
    type__in=['start_to_finish', 'finish_to_finish']
    )
    
    for task_dependencie in task_dependencies:
        task = task_dependencie.condition_task
        if (task_dependencie.type == 'start_to_finish'and task.status == 'pending') or \
           (task_dependencie.type == 'finish_to_finish'and task.status != 'completed'):
            return False

    return True

def creates_problems(validated_data):
    # (A -> B) with (A -> B)
    try:
        dependencie = Task_Dependencies.objects.filter(
            condition_task=validated_data['condition_task'],
            target_task=validated_data['target_task']
            ).get()
    except ObjectDoesNotExist:
        return False
    except MultipleObjectsReturned:
        return True
    if (dependencie.type == "finish_to_start" and validated_data['type'] == "start_to_finish") or \
       (dependencie.type == "start_to_finish" and validated_data['type'] == "finish_to_start") or \
       (dependencie.type == validated_data['type']):
            return True
    

    # (A -> B) with (B -> A)
    try:
        reverse_dependencie = Task_Dependencies.objects.filter(
            condition_task=validated_data['target_task'],
            target_task=validated_data['condition_task']
            ).get()
    except ObjectDoesNotExist:
        return False
    except MultipleObjectsReturned:
        return True

    if (reverse_dependencie.type == "finish_to_start" and validated_data['type'] == "start_to_finish") or \
       (reverse_dependencie.type == "start_to_finish" and validated_data['type'] == "finish_to_start") or \
       (reverse_dependencie.type == validated_data['type']):
            return True

    return False

def dfs_cycle_check(dependencies):
    graph = {}
    for dep in dependencies:
        src = dep.condition_task_id
        dst = dep.target_task_id
        etype = dep.type

        if src not in graph:
            graph[src] = []
        if dst not in graph:
            graph[dst] = []

        graph[src].append((dst, etype))

    visited = set()
    visiting = set()

    def dfs(node, path):
        if node in visiting:
            # Extract cycle path from first occurrence of node
            for idx, (u, v, etype) in enumerate(path):
                if u == node:
                    cycle_path = [u] + [v for (_, v, _) in path[idx:]]
                    return True, cycle_path
            return True, [node]  # fallback

        if node in visited:
            return False, []

        visiting.add(node)
        for neighbor, etype in graph.get(node, []):
            found, cycle_path = dfs(neighbor, path + [(node, neighbor, etype)])
            if found:
                return True, cycle_path
        visiting.remove(node)
        visited.add(node)
        return False, []

    for t in graph.keys():
        found, cycle_path = dfs(t, [])
        if found:
            return True, cycle_path
    return False, []