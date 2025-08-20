from services.fcm_service import NotificationService


def send(users , title , body , data=None):
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