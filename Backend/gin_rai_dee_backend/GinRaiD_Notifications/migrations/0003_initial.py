# Generated by Django 4.1.2 on 2022-10-12 02:29

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('GinRaiD_Notifications', '0002_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='notification',
            name='Receiver',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='Notifications', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='notification',
            name='Sender',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='Sender', to=settings.AUTH_USER_MODEL),
        ),
    ]
