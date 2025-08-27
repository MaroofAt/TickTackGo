from services.fcm_service import NotificationService


def send(users , title , body , data=None):
    if not users:
        return {'success': False, 'error': 'No users provided', 'details': 'Users parameter cannot be None or empty'}
    service = NotificationService()
    for user in users:
        result = service.send_to_user(
            user_id=user,
            title=title,
            body=body,
            data=data
        )
        if not result['success']:
            break
    return result