# Generated by Django 3.2.22 on 2024-01-09 04:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0007_checking_report'),
    ]

    operations = [
        migrations.AddField(
            model_name='student',
            name='Fee',
            field=models.CharField(default=1, max_length=4),
            preserve_default=False,
        ),
    ]
