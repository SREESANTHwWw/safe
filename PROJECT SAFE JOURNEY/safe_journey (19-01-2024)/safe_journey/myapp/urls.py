
from django.contrib import admin
from django.urls import path

from myapp import views

urlpatterns = (
    path('login/', views.loginn),
    path('login_post/', views.login_post),
    path('logout/',views.logout),
    path('add_bus/', views.add_bus),
    path('add_bus_post/', views.add_bus_post),

    path('add_student/', views.add_student),
    path('add_student_post/', views.add_student_post),

    path('add_driver/', views.add_driver),
    path('add_driver_post/', views.add_driver_post),

    path('view_driver/',views.view_driver),
    path('view_driver_post/',views.view_driver_post),

    path('password_change/', views.password_change),
    path('password_change_post/', views.password_change_post),
    path('send_payment_notification/<id>', views.send_payment_notification),
    path('send_payment_notification_post/<id>', views.send_payment_notification_post),
    path('student_bus_allocation/', views.student_bus_allocation),
    path('student_bus_allocation_post/', views.student_bus_allocation_post),
    path('view_bus/', views.view_bus),
    path('delete_bus/<id>',views.delete_bus),
    path('edit_bus/<id>',views.edit_bus),
    path('edit_bus_post/',views.edit_bus_post),
    path('view_bus_post/', views.view_bus_post),
    path('view_complaint_and_send_reply/', views.view_complaint_and_send_reply),
    path('view_complaint_and_send_reply_post/', views.view_complaint_and_send_reply_post),
    path('send_reply/<id>', views.send_reply),
    path('send_reply_post/', views.send_reply_post),
    path('view_payment_notification/<id>', views.view_payment_notification),
    path('view_payment_notification_post/', views.view_payment_notification_post),
    path('view_student_bus_allocation/', views.view_student_bus_allocation),
    path('view_student_bus_allocation_post/', views.view_student_bus_allocation_post),
    path('view_student/', views.view_student),
    path('view_student_post/', views.view_student_post),
    path('view_track_bus/', views.view_track_bus),
    path('view_track_bus_post/', views.view_track_bus_post),
    path('admin_home/', views.admin_home),
    path('allocation/',views.allocation),
    path('allocation_post/',views.allocation_post),
    path('edit_student_allocation/<id>',views.edit_student_allocation),
    path('edit_student_allocation_post/',views.edit_student_allocation_post),
    path('edit_student/<id>',views.edit_student),
    path('edit_student_post/',views.edit_student_post),
    path('delete_student/<id>',views.delete_student),
    path('send_reply/',views.send_reply),
    path('delete_student_allocation/<id>',views.delete_student_allocation),
    path('edit_driver/<id>',views.edit_driver),
    path('edit_driver_post/',views.edit_driver_post),
    path('delete_driver/<id>',views.delete_driver),
    path('forget_password/',views.forget_password),
    path('forget_password_post/',views.forget_password_post),
    path('send_fee_notification/',views.send_fee_notification),
    path('send_feenotificationpost/',views.send_feenotificationpost),
    path('parentviewpendingfee/',views.parentviewpendingfee),
    path('parentviewcompletedfee/',views.parentviewcompletedfee),
    path('feeupdation/',views.feeupdation),
    path('Change_password/',views.Change_password),



    ###################driver
    path('Login__post/',views.Login__post),
    path('update_vehicle_status_post/',views.update_vehicle_status_post),
    path('admin_view_due_report/',views.admin_view_due_report),
    path('admin_view_due_report_post/',views.admin_view_due_report_post),

    path('student_bus_entry_post/',views.student_bus_entry_post),
    path('send_message_to_admin_post/',views.send_message_to_admin_post),
    path('send_bus_related_message_to_parents_post/',views.send_bus_related_message_to_parents_post),
    path('update_location/',views.update_location),
    path('track_school_bus_post/',views.track_school_bus_post),
    path('view_message_from_school_post/',views.view_message_from_school_post),
    path('view_payment_alert_post/',views.view_payment_alert_post),
    path('view_notification_from_driver_post/',views.view_notification_from_driver_post),
    path('view_status_post/',views.view_status_post),
    path('view_driver_profile/',views.view_driver_profile),
    path('view_check_in_report/',views.view_check_in_report),
    path('view_message_to_admin/',views.view_message_to_admin),
    path('view_assigned_bus/',views.view_assigned_bus),
    path('view_my_send_message_to_parent/',views.view_my_send_message_to_parent),




    # parent
    path('view_reply/',views.view_reply),
    path('send_complaint_post/',views.send_complaint_post),
    path('view_parent_child/',views.view_parent_child),
    path('view_message_admin/',views.view_message_admin),
    path('view_parent_bus/',views.view_parent_bus),
    path('view_check_in_report_parent/',views.view_check_in_report_parent),
    path('view_parent_child1/',views.view_parent_child1),
    path('view_parent_bus1/',views.view_parent_bus1),

)
