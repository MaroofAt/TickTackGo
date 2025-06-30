import django_filters
from .models import User

class UserFilter(django_filters.FilterSet):
    created_at = django_filters.DateFilter(field_name='created_at__date')
    updated_at = django_filters.DateFilter(field_name='updated_at__date')
    class Meta:
        model= User
        fields = {
            'username': ['exact' , 'iexact' , 'icontains', 'contains'],
            'email': ['exact' , 'iexact' , 'icontains' , 'contains'],
            'created_at': ['exact' , 'lt' , 'gt' , 'range'],
            'updated_at': ['exact' , 'lt' , 'gt' , 'range'],
        }