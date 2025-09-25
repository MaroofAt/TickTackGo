from rest_framework import serializers
from django.core.files.uploadedfile import UploadedFile


class FlexibleFileListField(serializers.ListField):
        def to_internal_value(self, data):
            # Handle empty values
            if data in (None, '', [], {}):
                return []
            
            # If it's a single file, wrap it in a list
            if isinstance(data, UploadedFile):
                return [data]
            
            # If it's already a list, filter out non-files
            if isinstance(data, list):
                return [item for item in data if isinstance(item, UploadedFile)]
            
            # For any other case, return empty list
            return []