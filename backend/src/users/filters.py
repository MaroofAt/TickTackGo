import django_filters
from .models import User
from rest_framework import filters
from django.db.models import Q
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


class UserSearchFilter(filters.SearchFilter):
    def filter_queryset(self, request, queryset, view):
        search_terms = self.get_search_terms(request)
        
        if not search_terms:
            return queryset
        
        # Custom search logic for email field
        conditions = []
        for term in search_terms:
            # For email field, search only the part before @
            email_condition = Q(email__istartswith=term + '@') | Q(email__icontains=term + '@')
            username_condition = Q(username__icontains=term)
            conditions.append(email_condition | username_condition)
        
        return queryset.filter(*conditions)