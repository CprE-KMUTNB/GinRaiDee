# Generated by Django 4.1.2 on 2022-10-24 10:18

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('GinRaiD_Recipes', '0002_initial'),
        ('GinRaiD_Reports', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='report',
            name='reporter',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reporter', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='report',
            name='target_object',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='menu', to='GinRaiD_Recipes.menu'),
        ),
    ]
