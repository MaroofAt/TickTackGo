from rest_framework.response import Response
from rest_framework import status


def exception_response(e):
    return Response(
        {'Exception': str(e)},
        status=status.HTTP_500_INTERNAL_SERVER_ERROR
    )

def required_response(field_name):
    return Response(
        {'detail': f'{field_name} is required'},
        status=status.HTTP_400_BAD_REQUEST
    )
def method_not_allowed():
    return Response(
        {"detail": "Method not allowed"},
        status=status.HTTP_405_METHOD_NOT_ALLOWED
    )