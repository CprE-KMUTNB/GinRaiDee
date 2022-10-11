from .models import Report
from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from . import serializers


class ReportViewsets(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.ReportSerializer
    queryset = Report.objects.all()
    permission_classes = (
        IsAuthenticated,
    )
    http_method_names = ['post']

    def perform_create(self, serializer):
        serializer.save(reporter=self.request.user)


