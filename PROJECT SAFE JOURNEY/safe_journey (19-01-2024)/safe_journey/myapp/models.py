from django.db import models

# Create your models here.
class login(models.Model):
    username=models.CharField(max_length=200)
    password=models.CharField(max_length=200)
    type=models.CharField(max_length=200)


class student(models.Model):
    LOGIN=models.ForeignKey(login,default=1,on_delete=models.CASCADE)
    Name=models.CharField(max_length=200)
    Place= models.CharField(max_length=200)
    Post= models.CharField(max_length=200)
    Pin = models.CharField(max_length=200)
    House_name= models.CharField(max_length=200)
    Parent_name= models.CharField(max_length=200)
    Parent_number= models.CharField(max_length=200)
    Register_number=models.CharField(max_length=200)
    Gender= models.CharField(max_length=200)
    Phone_number= models.CharField(max_length=200)
    E_mail= models.CharField(max_length=200)
    Fee= models.CharField(max_length=10)


class driver(models.Model):
    Name = models.CharField(max_length=200)
    Place = models.CharField(max_length=200)
    Post = models.CharField(max_length=200)
    Pin = models.CharField(max_length=200)
    House_name = models.CharField(max_length=200)
    Phone_number = models.CharField(max_length=200)
    E_mail = models.CharField(max_length=200)
    Experience = models.CharField(max_length=200)
    Licence_number = models.CharField(max_length=200)
    photo=models.CharField(max_length=350)
    DOB= models.DateField()
    Gender= models.CharField(max_length=100,default=1)
    LOGIN = models.ForeignKey(login, default=1, on_delete=models.CASCADE)


class bus(models.Model):
    Bus_number = models.CharField(max_length=200)
    Bus_type = models.CharField(max_length=200)
    Total_seat = models.CharField(max_length=200)
    Photo = models.CharField(max_length=200)
    Chasis_number= models.CharField(max_length=200)
    DRIVER= models.ForeignKey(driver, default=1, on_delete=models.CASCADE)


class student_allocation(models.Model):
    BUS = models.ForeignKey(bus, default=1, on_delete=models.CASCADE)
    STUDENT = models.ForeignKey(student, default=1, on_delete=models.CASCADE)
    Status = models.CharField(max_length=200)


class payment_notification(models.Model):
    Month = models.CharField(max_length=200)
    Year = models.CharField(max_length=200)
    Fee = models.CharField(max_length=200)
    Last_date = models.CharField(max_length=200)
    Status = models.CharField(max_length=200)
    STUDENT = models.ForeignKey(student, default=1, on_delete=models.CASCADE)


class complaint(models.Model):
    Date = models.DateField()
    Complaint = models.CharField(max_length=600)
    STUDENT = models.ForeignKey(student, default=1, on_delete=models.CASCADE)
    Reply = models.CharField(max_length=600)
    Status = models.CharField(max_length=200)


class track(models.Model):
    Latitude = models.CharField(max_length=200)
    Longitude = models.CharField(max_length=200)
    Date = models.CharField(max_length=200)
    BUS = models.ForeignKey(bus, on_delete=models.CASCADE)


class message(models.Model):
    LOGIN = models.ForeignKey(login, default=1, on_delete=models.CASCADE)
    Message = models.CharField(max_length=200)
    Type= models.CharField(max_length=200)
    Date = models.CharField(max_length=200)


# class driver_message(models.Model):
#     Message = models.CharField(max_length=200)
#     Date = models.CharField(max_length=200)
#     Allocation_ID = models.ForeignKey(student_allocation, default=1, on_delete=models.CASCADE)
#     DRIVER_ID = models.ForeignKey(login, default=1, on_delete=models.CASCADE)

class  Checking_report(models.Model):
    status = models.CharField(max_length=200)
    checkin_time = models.CharField(max_length=200)
    checkout_time = models.CharField(max_length=200)
    Date = models.CharField(max_length=200)
    STUDENT=models.ForeignKey(student, default=1, on_delete=models.CASCADE)


