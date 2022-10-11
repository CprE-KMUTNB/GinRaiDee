from django.contrib import admin
from .models import Report

class ReportAdmin(admin.ModelAdmin):
    list_filter = [
        'reporter',
        'target_object',
        'report_text',
    ]

    search_fields = (
        'reporter__username',
        'target_object__Foodname',
        'report_text',
    )

admin.site.register(Report,ReportAdmin)
