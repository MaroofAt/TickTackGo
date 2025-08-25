
from django.conf import settings

def calculate_task_long_in_days(start_date, due_date):
    delta = (due_date - start_date)
    return abs(delta.days) + 1

def calculate_discipline_status(complete_date, due_date):
    if complete_date == due_date:
        return 'on-time'
    if complete_date < due_date:
        return 'before-time'
    return 'after-time'
    
def calculate_task_points(task):
    # hard_work
    task_long_in_days = calculate_task_long_in_days(task.start_date, task.due_date)
    
    hard_work_points = task_long_in_days * settings.DAY_POINTS
    
    # important_missions
    important_mission_points = settings.LOW_PRIORITY_MISSION
    if task.priority == 'high':
        important_mission_points = settings.HIGH_PRIORITY_MISSION
    elif task.priority == 'medium':
        important_mission_points = settings.MEDIUM_PRIORITY_MISSION
    
    # discipline
    discipline_status = calculate_discipline_status(task.complete_date , task.due_date)
    
    discipline_points = settings.FINISHED_AFTER_TIME
    if discipline_status == 'on-time':
        discipline_points = settings.FINISHED_ON_TIME
    elif discipline_points == 'before-time':
        discipline_points = settings.FINISHED_BEFORE_TIME

    # total
    total = hard_work_points + important_mission_points + discipline_points

    return {
        'total': total,
        'hard_work_points':hard_work_points,
        'important_mission_points':important_mission_points,
        'discipline_points':discipline_points,
    }