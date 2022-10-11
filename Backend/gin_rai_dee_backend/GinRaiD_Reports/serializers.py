from rest_framework import serializers
from .models import Report


class ReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = Report
        fields = ('id', 'reporter', 'report_text', 'target_object')
        extra_kwargs = {
            'reporter': {'read_only':True},
        }