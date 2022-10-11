from django.db import models
from GinRaiD_UserAPI.models import UserProfile
from GinRaiD_Recipes.models import Menu


class Report(models.Model):
    reporter = models.ForeignKey(UserProfile,on_delete=models.CASCADE,related_name='reporter')
    target_object = models.ForeignKey(Menu,on_delete=models.CASCADE,related_name='menu')
    report_text = models.TextField()

    def __str__(self):
        return 'reporter :'+self.reporter.username+' |cause :'+self.report_text

