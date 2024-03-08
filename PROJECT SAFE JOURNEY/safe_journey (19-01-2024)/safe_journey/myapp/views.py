import datetime

from django.conf import settings
from django.core.files.storage import FileSystemStorage
from django.core.mail import send_mail
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

# Create your views here.
from myapp.models import *



def admin_view_due_report(request):
    obj=payment_notification.objects.filter(Status="pending")
    return render(request,"admin/view due report.html",{"data":obj})

def admin_view_due_report_post(request):
    search1=request.POST['textfield']
    search2=request.POST['textfield2']
    obj=payment_notification.objects.filter(Status="pending",Last_date__range=[search1,search2])
    return render(request,"admin/view due report.html",{"data":obj})

def loginn(request):
    return render(request,"loginindex.html")
def login_post(request):
    username=request.POST['textfield']
    password = request.POST['textfield2']
    res=login.objects.filter(username=username,password=password)
    if res.exists():
        ress=login.objects.get(username=username,password=password)
        request.session['log']="lin"
        if ress.type=='admin':
            return HttpResponse('''<script>alert("Login successfully ");window.location='/myapp/admin_home/'</script>''')
        else:
            return HttpResponse('''<script>alert("User not found");window.location='/myapp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("User not found");window.location='/myapp/login/'</script>''')
def logout(request):
    request.session['log'] = ''
    return HttpResponse('''<script>alert("Logout Successfully");window.location='/myapp/login/'</script>''')


def add_bus(request):
    if request.session['log'] == 'lin':
        dobj = driver.objects.all()
        return render(request, "admin/add bus.html", {"data": dobj})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def add_bus_post(request):
    if request.session['log'] == 'lin':
        bus_number = request.POST['textfield1']
        bus_type = request.POST['select']
        total_seat = request.POST['textfield2']
        Chasis_number = request.POST['textfield4']
        driver = request.POST['select2']
        photo = request.FILES['fileField3']
        if bus.objects.filter(Bus_number=bus_number).exists():
            return HttpResponse('''<script>alert("Bus number already exist!");history.back()</script>''')

        fs = FileSystemStorage()
        date = datetime.datetime.now().strftime("%y%m%d-%H%M%S") + ".jpg"
        fn = fs.save(date, photo)
        path = fs.url(date)
        bobj = bus()
        bobj.Bus_number = bus_number
        bobj.Bus_type = bus_type
        bobj.Total_seat = total_seat
        bobj.Photo = path
        bobj.Chasis_number = Chasis_number
        bobj.DRIVER_id = driver
        bobj.save()

        return HttpResponse('''<script>alert("Bus added successfully");window.location='/myapp/add_bus/'</script>''')
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def delete_bus(request,id):
    if request.session['log']== "lin":
        gobj=bus.objects.get(id=id).delete()
        return HttpResponse('''<script>alert("Deleted successfully");window.location='/myapp/view_bus/'</script>''')
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def edit_bus(request,id):
    if request.session['log'] == 'lin':
        dobj = driver.objects.all()
        gobj = bus.objects.get(id=id)
        return render(request, "admin/edit bus.html", {'data': dobj, 'data1': gobj})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def edit_bus_post(request):
    if request.session['log'] == 'lin':
        bus_number = request.POST['textfield1']
        bus_type = request.POST['select']
        total_seat = request.POST['textfield2']
        Chasis_number = request.POST['textfield4']
        driver = request.POST['select2']
        did=request.POST['id1']
        if 'fileField3' in request.FILES:
            photo = request.FILES['fileField3']
            fs = FileSystemStorage()
            date = datetime.datetime.now().strftime("%y%m%d-%H%M%S") + ".jpg"
            fn = fs.save(date, photo)
            path = fs.url(date)
            bobj = bus.objects.get(id=did)
            bobj.Bus_number = bus_number
            bobj.Bus_type = bus_type
            bobj.Total_seat = total_seat
            bobj.Photo = path
            bobj.Chasis_number =Chasis_number
            bobj.DRIVER_id = driver
            bobj.save()

            return HttpResponse('''<script>alert("Edited successfully");window.location='/myapp/view_bus/'</script>''')
        else:
            bobj = bus.objects.get(id=did)
            bobj.Bus_number = bus_number
            bobj.Bus_type = bus_type
            bobj.Total_seat = total_seat
            bobj.Chasis_number = Chasis_number
            bobj.DRIVER_id = driver
            bobj.save()

        return HttpResponse('''<script>alert("Edited successfully");window.location='/myapp/view_bus/'</script>''')

    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')
def add_student(request):
    if request.session['log'] == 'lin':
        return render(request, "admin/add student.html")
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')
def add_student_post(request):
    if request.session['log'] == 'lin':
        Name = request.POST['textfield']
        Place = request.POST['textfield2']
        Post = request.POST['textfield3']
        Pin = request.POST['textfield4']
        House_Name = request.POST['textfield5']
        Parent_Name = request.POST['textfield6']
        Parent_Number = request.POST['textfield7']
        Register_Number = request.POST['textfield8']
        Gender = request.POST['radio']
        Phone_Number = request.POST['textfield9']
        E_mail = request.POST['textfield10']
        Fee = request.POST['textfield11']

        Var=login()
        Var.username=E_mail
        Var.password=Parent_Number
        Var.type='parent'
        Var.save()


        sobj = student()
        sobj.LOGIN=Var
        sobj.Name = Name
        sobj.Place = Place
        sobj.Post = Post
        sobj.Pin = Pin
        sobj.House_name = House_Name
        sobj.Parent_name = Parent_Name
        sobj.Parent_number = Parent_Number
        sobj.Register_number = Register_Number
        sobj.Gender = Gender
        sobj.Fee=Fee
        sobj.Phone_number = Phone_Number
        sobj.E_mail = E_mail
        sobj.save()

        return HttpResponse('''<script>alert("Student added successfully ");window.location='/myapp/add_student/'</script>''')
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')
def password_change(request):
    if request.session['log'] == 'lin':
        return render(request, "admin/password change.html")
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')
def password_change_post(request):
    if request.session['log'] == 'lin':
        Old_password= request.POST['textfield']
        New_password= request.POST['textfield2']
        Confirm_password = request.POST['textfield3']
        res=login.objects.filter(password=Old_password)
        if res.exists():
            if New_password==Confirm_password:
                login.objects.filter(type='admin').update(password=New_password)
                return HttpResponse('''<script>alert("Password changed successfully");window.location='/myapp/logout/'</script>''')
            else:
                return HttpResponse('''<script>alert("Those passwords didn’t match. Try again");history.back()</script>''')

        else:
            return HttpResponse('''<script>alert("Old password entered incorrectly");history.back()</script>''')
    else:

            return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def send_payment_notification(request,id):
    if request.session['log'] == 'lin':
        return render(request, "admin/send payment notification.html", {'id': id})
    else:
         return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def send_payment_notification_post(request,id):
    Month= request.POST['textfield']
    Fee= request.POST['textfield2']
    Last_date= request.POST['textfield3']

    nobj=payment_notification()
    nobj.ALLOCATION_id=id
    nobj.Month=Month
    nobj.Fee=Fee
    nobj.Status='pending'
    nobj.Last_date=Last_date
    nobj.save()



    return HttpResponse('''<script>alert("Payment notification send");window.location='/myapp/allocation/'</script>''')

def allocation(request):
    if request.session['log'] == 'lin':
        res = student_allocation.objects.all()
        return render(request, "admin/allocation.html", {'data': res})
    else:

        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def allocation_post(request):
    if request.session['log'] == 'lin':
        search = request.POST['textfield']
        res = student_allocation.objects.filter(BUS__Bus_number__icontains=search)
        return render(request, "admin/allocation.html", {'data': res})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def delete_student_allocation(request,id):
    gobj=student_allocation.objects.get(id=id).delete()
    return HttpResponse('''<script>alert("Deleted successfully");window.location='/myapp/allocation/'</script>''')

def edit_student_allocation(request,id):
    if request.session['log'] == 'lin':
        res=student_allocation.objects.get(id=id)
        gobj=bus.objects.all()
        bobj=student.objects.all()
        return render(request,"admin/edit student allocation.html",{'data':res,'data2':gobj,'data3':bobj})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def edit_student_allocation_post(request):
    if request.session['log'] == 'lin':
        Student_Name = request.POST['select']
        Bus_Number = request.POST['select2']
        id=request.POST['id']
        obj = student_allocation.objects.get(id=id)
        obj.BUS_id = Bus_Number
        obj.STUDENT_id = Student_Name
        obj.save()
        return HttpResponse('''<script>alert("Updated successfully");window.location='/myapp/allocation/'</script>''')
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')




def student_bus_allocation(request):
    if request.session['log'] == 'lin':
        res=student.objects.all()
        ob=bus.objects.all()
        return render(request,"admin/student bus allocation.html",{'data':res,'data1':ob})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def student_bus_allocation_post(request):
    if request.session['log'] == 'lin':
        Student_Name = request.POST['select']
        Bus_Number = request.POST['select2']
        if student_allocation.objects.filter(STUDENT_id=Student_Name).exists():
            return HttpResponse('''<script>alert("Bus number already exists!");history.back()</script>''')

        obj = student_allocation()
        obj.BUS_id = Bus_Number
        obj.STUDENT_id = Student_Name
        obj.Status = 'allocated'
        obj.save()

        return HttpResponse('''<script>alert("Allocated successfully");window.location='/myapp/student_bus_allocation/'</script>''')
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def view_bus(request):
    if request.session['log'] == 'lin':
        res=bus.objects.all()
        return render(request,"admin/view bus.html",{'data':res})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_bus_post(request):
    if request.session['log'] == 'lin':
        Bus_Number= request.POST['textfield']
        res=bus.objects.filter(Bus_number__icontains=Bus_Number)

        return render(request, "admin/view bus.html", {'data': res})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_complaint_and_send_reply(request):
    if request.session['log'] == 'lin':
        res = complaint.objects.all()
        return render(request, "admin/view complaint and send reply.html", {'data': res})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_complaint_and_send_reply_post(request):
    if request.session['log'] == 'lin':
        From = request.POST['textfield']
        To = request.POST['textfield2']

        if 'button2' in request.POST:
            reply = request.POST['textarea']
            id = request.POST['id1']
            ob = complaint.objects.get(id=id)
            ob.Reply = reply
            ob.Status = "replied"
            ob.save()
            return HttpResponse('''<script>alert("replied successfully");window.location='/myapp/view_complaint_and_send_reply/'</script>''')
        res = complaint.objects.filter(Date__range=[From, To])

        return render(request, "admin/view complaint and send reply.html", {'data': res})
    else:
         return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def send_reply(request,id):
    if request.session['log'] == 'lin':
        # reply=request.POST['textarea']
        var=complaint.objects.get(id=id)


        return render(request,'admin/sendreply.html',{'data':var})
    else:
         return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def send_reply_post(request):
    if request.session['log'] == 'lin':
        reply = request.POST['textarea']
        id = request.POST['id']
        ob = complaint.objects.get(id=id)
        ob.Reply = reply
        ob.Status = "replied"
        ob.save()
        return HttpResponse('''<script>alert("replied successfully");window.location='/myapp/view_complaint_and_send_reply/'</script>''')

    else:
         return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_payment_notification(request,id):
    if request.session['log'] == 'lin':
        # res = payment_notification.objects.filter(ALLOCATION=id)
        res = payment_notification.objects.filter(id=id)
        return render(request,"admin/view payment notification.html",{'data':res})

    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_payment_notification_post(request):
    if request.session['log'] == 'lin':
        Month = request.POST['textfield']
        res = payment_notification.objects.filter(Month__icontains=Month)

        return render(request, "admin/view payment notification.html", {'data': res})

    else:
       return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def view_student_bus_allocation(request):
    if request.session['log'] == 'lin':
        res=student_allocation.objects.all()
        return render(request, "admin/view student bus allocation.html",{'data':res})

    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_student_bus_allocation_post(request):
    if request.session['log'] == 'lin':
        Student_name = request.POST['textfield']
        res = student_allocation.objects.filter(STUDENT__Name__icontains=Student_name)
        return render(request, "admin/view student bus allocation.html", {'data': res})

    else:
       return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_student(request):
    if request.session['log'] == 'lin':
        res=student.objects.all()
        return render(request,"admin/view student.html",{'data':res})

    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_student_post(request):
    if request.session['log'] == 'lin':
        Student_name = request.POST['textfield']
        res = student.objects.filter(Name__icontains=Student_name)
        return render(request, "admin/view student.html", {'data': res})

    else:
       return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def view_track_bus(request):
    if request.session['log'] == 'lin':
        return render(request, "admin/view track bus.html")
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_track_bus_post(request):
    if request.session['log'] == 'lin':
        return HttpResponse('''<script>alert("track bus viewed");window.location='/myapp/view_track_bus/'</script>''')
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def add_driver(request):
    if request.session['log'] == 'lin':
        return render(request, "admin/add driver.html")
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def add_driver_post(request):
    if request.session['log'] == 'lin':
        Name= request.POST['textfield']
        Place= request.POST['textfield2']
        Post= request.POST['textfield3']
        Pin= request.POST['textfield4']
        House_Name= request.POST['textfield5']
        Phone_Number= request.POST['textfield6']
        E_mail= request.POST['textfield7']
        Experience= request.POST['textfield8']
        Licence_number = request.POST['textfield9']
        if login.objects.filter(username__icontains=E_mail).exists():
            return HttpResponse('''<script>alert("E-mail already exists!");history.back()</script>''')

        from datetime import datetime
        date=datetime.now().strftime("%Y%m%d-%H%M%S")+".jpg"
        Photo= request.FILES['textfield10']
        fs=FileSystemStorage()
        fs.save(date,Photo)
        path=fs.url(date)
        DOB= request.POST['textfield11']
        Gender= request.POST['radio']
        import random
        password=random.randint(0000,9999)

        obj=login()
        obj.username=E_mail
        obj.password=password
        obj.type='driver'
        obj.save()

        dobj=driver()
        dobj.Name=Name
        dobj.Place=Place
        dobj.Post=Post
        dobj.Pin=Pin
        dobj.House_name=House_Name
        dobj.Phone_number=Phone_Number
        dobj.E_mail=E_mail
        dobj.Experience=Experience
        dobj.Licence_number=Licence_number
        dobj.photo=path
        dobj.DOB=DOB
        dobj.Gender=Gender
        dobj.LOGIN=obj
        dobj.save()

        return HttpResponse('''<script>alert("Driver added succesfully");window.location='/myapp/add_driver/'</script>''')
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_driver(request):
    if request.session['log'] == 'lin':
        vars = driver.objects.all()
        return render(request, 'admin/view driver.html', {'data': vars})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def view_driver_post(request):
    if request.session['log'] == 'lin':
        search = request.POST['textfield']
        vars = driver.objects.filter(Name__icontains=search)
        return render(request, 'admin/view driver.html', {'data': vars})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


# def

def edit_driver(request,id):
    if request.session['log'] == 'lin':
        res = driver.objects.get(id=id)
        return render(request, "admin/edit driver.html", {'data': res})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def edit_driver_post(request):
    if request.session['log'] == 'lin':
        Name = request.POST['textfield']
        Place = request.POST['textfield2']
        Post = request.POST['textfield3']
        Pin = request.POST['textfield4']
        House_Name = request.POST['textfield5']
        Phone_Number = request.POST['textfield6']
        E_mail = request.POST['textfield7']
        Experience = request.POST['textfield8']
        Licence_number = request.POST['textfield9']
        DOB = request.POST['textfield11']
        Gender = request.POST['radio']
        id=request.POST['id']
        if 'textfield10' in request.FILES:
            Photo = request.FILES['textfield10']

            from datetime import datetime
            date = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
            fs = FileSystemStorage()
            fs.save(date, Photo)
            path = fs.url(date)

            dobj = driver.objects.get(id=id)
            dobj.Name = Name
            dobj.Place = Place
            dobj.Post = Post
            dobj.Pin = Pin
            dobj.House_name = House_Name
            dobj.Phone_number = Phone_Number
            dobj.E_mail = E_mail
            dobj.Experience = Experience
            dobj.Licence_number = Licence_number
            dobj.photo = path
            dobj.DOB = DOB
            dobj.Gender = Gender
            dobj.save()
            return HttpResponse('''<script>alert("Updated successfully");window.location='/myapp/view_driver/'</script>''')
        else:
            dobj = driver.objects.get(id=id)
            dobj.Name = Name
            dobj.Place = Place
            dobj.Post = Post
            dobj.Pin = Pin
            dobj.House_name = House_Name
            dobj.Phone_number = Phone_Number
            dobj.E_mail = E_mail
            dobj.Experience = Experience
            dobj.Licence_number = Licence_number
            dobj.DOB = DOB
            dobj.Gender = Gender
            dobj.save()

            return HttpResponse('''<script>alert("Updated successfully");window.location='/myapp/view_driver/'</script>''')
    else:
            return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def delete_driver(request,id):
    gobj=driver.objects.get(id=id).delete()
    return HttpResponse('''<script>alert("Deleted successfully");window.location='/myapp/view_driver/'</script>''')



def admin_home(request):
    return render(request, "admin/adminindex.html")



def delete_student(request,id):
    gobj=student.objects.get(id=id).delete()
    return HttpResponse('''<script>alert("Deleted successfully");window.location='/myapp/view_student/'</script>''')

def edit_student(request,id):
    if request.session['log'] == 'lin':
        res=student.objects.get(id=id)
        return render(request,"admin/edit student.html",{'data':res})
    else:
        return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')

def edit_student_post(request):
    if request.session['log'] == 'lin':
        Name= request.POST['textfield']
        Place= request.POST['textfield2']
        Post= request.POST['textfield3']
        Pin= request.POST['textfield4']
        House_Name= request.POST['textfield5']
        Parent_Name= request.POST['textfield6']
        Parent_Number= request.POST['textfield7']
        Register_Number= request.POST['textfield8']
        Gender= request.POST['radio']
        Phone_Number= request.POST['textfield9']
        E_mail= request.POST['textfield10']
        Fee= request.POST['textfield11']
        id=request.POST['id']
        sobj=student.objects.get(id=id)
        sobj.Name=Name
        sobj.Place=Place
        sobj.Post=Post
        sobj.Pin=Pin
        sobj.House_name=House_Name
        sobj.Parent_name=Parent_Name
        sobj.Parent_number=Parent_Number
        sobj.Register_number=Register_Number
        sobj.Gender=Gender
        sobj.Phone_number=Phone_Number
        sobj.E_mail=E_mail
        sobj.Fee=Fee
        sobj.save()

        return HttpResponse('''<script>alert("Student update successfully ");window.location='/myapp/view_student/'</script>''')
    else:
         return HttpResponse('''<script>alert(" Already Logouted");window.location='/myapp/login/'</script>''')


def forget_password(request):
    return render(request,'forgetpassword.html')

def forget_password_post(request):
    em = request.POST['em_add']
    import random
    password = random.randint(00000000, 99999999)
    log = login.objects.filter(username=em)
    if log.exists():
        logg = login.objects.get(username=em)
        message = 'temporary password is ' + str(password)
        send_mail(
            'temp password',
            message,
            settings.EMAIL_HOST_USER,
            [em, ],
            fail_silently=False
        )
        logg.password = password
        logg.save()
        return HttpResponse('<script>alert("success");window.location="/myapp/login/"</script>')
    else:
        return HttpResponse('<script>alert("invalid email");window.location="/myapp/login/"</script>')



    #############################Driver###################

def Login__post(request):
    # lid = request.POST['lid']
    username = request.POST['uname']
    password = request.POST['password']
    res = login.objects.filter(username=username, password=password)
    if res.exists():
        res1 = login.objects.get(username=username, password=password)
        print(res1)
        # res1.id=lid

        if res1.type=='driver':
            var3 = driver.objects.get(LOGIN_id=res1.id)

            return JsonResponse({'status': 'ok', 'type': res1.type, 'lid': res1.id,'name':var3.Name, 'photo':var3.photo})
        elif res1.type=='parent':
            var=student.objects.get(LOGIN_id=res1.id)
            return JsonResponse({'status': 'ok', 'type': res1.type, 'lid': res1.id,'name':var.Name, 'photo':''})
        else:
            return JsonResponse({'status': 'No'})
    else:
        return JsonResponse({'status': 'No'})

def update_vehicle_status_post(request):
    bus_id=request.POST['bus_id']
    return JsonResponse({'status':'ok'})

def student_bus_entry_post(request):
        return JsonResponse({'status':'ok'})

def send_message_to_admin_post(request):
    lid=request.POST['lid']
    messages=request.POST['message']
    zobj=message()
    zobj.Message=messages
    zobj.LOGIN_id=lid
    zobj.Date=datetime.date.today()
    zobj.Type='admin'
    zobj.save()

    return JsonResponse({'status':'ok'})



def view_my_send_message_to_parent(request):
    lid = request.POST['lid']
    vobj = message.objects.filter(LOGIN_id=lid)
    l = []
    for i in vobj:
        l.append({'id': i.id, 'Message': i.Message, 'Type': i.Type, 'Date': i.Date})
    return JsonResponse({'status': 'ok', 'data': l})


def send_bus_related_message_to_parents_post(request):
    lid = request.POST['lid']
    print(lid)
    msg = request.POST['msgparent']
    zobj = message()
    zobj.Message = msg
    zobj.LOGIN_id = lid
    zobj.Date = datetime.date.today()
    zobj.Type = 'driver'
    zobj.save()
    return JsonResponse({'status':'ok'})

def update_location(request):
    print(request.POST)
    lid = request.POST['lid']
    latitude = request.POST['latitude']
    longitude = request.POST['longitude']
    if latitude != '':
        zobj = track()
        zobj.Latitude = latitude
        zobj.Longitude = longitude
        zobj.Date = datetime.date.today()
        zobj.BUS = bus.objects.get(DRIVER__LOGIN_id=lid)
        zobj.save()
    return JsonResponse({'status':'ok'})

   ######parent#####
def track_school_bus_post(request):
        return JsonResponse({'status':'ok'})

def view_message_from_school_post(request):
    vobj=message.objects.all()
    l=[]
    for i in vobj:
        l.append({'id':i.id,'Message':i.Message,'Type':i.Type,'Date':i.Date})
    return JsonResponse({'status':'ok', 'data':l})

def view_payment_alert_post(request):
    vobj =payment_notification.objects.all()
    l = []
    for i in vobj:
        l.append({'id': i.id, 'Month': i.Month, 'Fee': i.Fee, 'Last_date': i.Last_date,'Status': i.Status,'ALLOCATION_id': i.ALLOCATION_id})
    return JsonResponse({'status': 'ok', 'data': l})

def view_notification_from_driver_post(request):
    lid = request.POST['lid']
    vobj = message.objects.filter(Type="driver",LOGIN__driver__bus=student_allocation.objects.get(STUDENT__LOGIN_id=lid).BUS)
    l = []
    for i in vobj:
        Name=driver.objects.get(LOGIN_id=i.LOGIN_id).Name
        l.append({'id': i.id, 'Message': i.Message, 'Type': i.Type, 'Date': i.Date, 'Name':Name})
    return JsonResponse({'status':'ok','data':l})

def send_complaint_post(request):
    lid = request.POST['lid']
    complaints = request.POST['complaint']
    zobj=complaint()
    zobj.Date=datetime.datetime.now().today().date()
    zobj.Complaint=complaints
    zobj.Reply='pending'
    zobj.Status='pending'
    zobj.STUDENT=student.objects.get(LOGIN_id=lid)
    zobj.save()
    return JsonResponse({'status':'ok'})






def view_status_post(request):
    vobj = complaint.objects.all()
    l = []
    for i in vobj:
        l.append({'id': i.id, 'Date': i.Date, 'Complaint': i.Complaint, 'Reply': i.Reply,'Status': i.Status,'STUDENT_id': i.STUDENT_id})
    return JsonResponse({'status':'ok'})

def view_driver_profile(request):
    lid=request.POST['lid']
    cobj=driver.objects.get(LOGIN_id=lid)
    return JsonResponse({'status': 'ok','Name':cobj.Name,'Place':cobj.Place,'Post':cobj.Post,'Pin':cobj.Pin,'House_name':cobj.House_name,'Phone_number':cobj.Phone_number,'E_mail':cobj.E_mail,'Experience':cobj.Experience,'Licence_number':cobj.Licence_number,'photo':cobj.photo,'DOB':cobj.DOB,'Gender':cobj.Gender})




def view_assigned_bus(request):
    lid=request.POST['lid']
    xobj=bus.objects.filter(DRIVER__LOGIN_id=lid)
    l=[]
    for i in xobj:
        l.append({'id':i.id,
                  'Bus_number':i.Bus_number,
                  'Bus_type':i.Bus_type,
                  'Total_seat':i.Total_seat,
                  'Photo':i.Photo})
    return JsonResponse({'status': 'ok','data':l})






def view_reply(request):
    lid=request.POST['lid']
    var=complaint.objects.filter(STUDENT__LOGIN_id=lid)
    l=[]
    for i in var:
        l.append({'id':i.id,
                  'Date':i.Date,
                  'Complaint':i.Complaint,
                  'Reply':i.Reply,
                  'Status':i.Status})
    return JsonResponse({'status': 'ok', 'data': l})


def view_parent_child(request):
    lid=request.POST['lid']
    var=student.objects.filter(LOGIN_id=lid)
    l=[]
    for i in var:
        l.append({'id':i.id,'Name':i.Name,'Place':i.Place,'Post':i.Post,'Pin':i.Pin,'House_name':i.House_name,'Register_number':i.Register_number,'Gender':i.Gender,'Phone_number':i.Phone_number,'E_mail':i.E_mail})
    return JsonResponse({'status': 'ok', 'data': l})

def view_parent_child1(request):
    lid=request.POST['lid']
    var=student.objects.filter(LOGIN_id=lid)
    l=[]
    for i in var:
        l.append({'id':i.id,'Name':i.Name,'Place':i.Place,'Post':i.Post,'Pin':i.Pin,'House_name':i.House_name,'Register_number':i.Register_number,'Gender':i.Gender,'Phone_number':i.Phone_number,'E_mail':i.E_mail})
    print(l[0])
    return JsonResponse({'status': 'ok', 'data': l[0]})

def view_parent_bus1(request):
    lid=request.POST['lid']
    print(lid)
    var=student_allocation.objects.filter(STUDENT__LOGIN_id=lid)
    l=[]
    for i in var:
        l.append({'id':i.id,'busnum':i.BUS.Bus_number,'bustype':i.BUS.Bus_type,'driver':i.BUS.DRIVER.Name,'dpho':i.BUS.DRIVER.photo,'phone':i.BUS.DRIVER.Phone_number,'photo':i.BUS.Photo})
    print(l)
    return JsonResponse({'status': 'ok', 'data': l[0]})



def parentviewpendingfee(request):
    lid= request.POST["lid"]

    var= payment_notification.objects.filter(STUDENT__LOGIN_id= lid,Status="pending")

    l = []
    for i in var:
        l.append(
            {'id': i.id,
             'Name': i.STUDENT.Name,
             'Register_number': i.STUDENT.Register_number,
             'Month': i.Month,
             'Year': i.Year,
             'Fee': i.STUDENT.Fee,
             'Last_date': i.Last_date,
             })
    return JsonResponse({'status': 'ok', 'data': l})


def parentviewcompletedfee(request):
    lid= request.POST["lid"]

    var= payment_notification.objects.filter(STUDENT__LOGIN_id= lid,Status="done")

    l = []
    for i in var:
        l.append(
            {'id': i.id,
             'Name': i.STUDENT.Name,
             'Register_number': i.STUDENT.Register_number,
             'Month': i.Month,
             'Year': i.Year,
             'Fee': i.STUDENT.Fee,
             'Last_date': i.Last_date,
             })
    return JsonResponse({'status': 'ok', 'data': l})



def view_parent_bus(request):
    lid=request.POST['lid']
    print(lid)
    var=student_allocation.objects.filter(STUDENT__LOGIN_id=lid)
    l=[]
    for i in var:
        latitude_ =  ''
        longitude_ =  ''
        if track.objects.filter(BUS__student_allocation=i).exists():
            loc = track.objects.filter(BUS__student_allocation=i).order_by('-id')[0]
            latitude_=loc.Latitude
            longitude_=loc.Longitude
        l.append({str('id'):i.id,'busnum':i.BUS.Bus_number,
                  'bustype':i.BUS.Bus_type,'driver':i.BUS.DRIVER.Name,
                  'dpho':i.BUS.DRIVER.photo,'phone':i.BUS.DRIVER.Phone_number,
                  'photo':i.BUS.Photo,
                  'latitude_':latitude_,
                  'longitude_':longitude_,
                  })
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})


def view_message_admin(request):
    dobj=message.objects.all()
    l=[]
    for i in dobj:
        name=''
        if i.Type=='parent':
            name=driver.objects.get(LOGIN_id=i.LOGIN_id)


            l.append({'name':name.Name,'message':i.Message,'type':i.Type,'date':i.Date})
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})


def view_message_to_admin(request):
    lid=request.POST['lid']
    fobj=message.objects.filter(Type='admin', LOGIN_id=lid)
    l=[]
    for i in fobj:
        l.append({'id':i.id,'Message':i.Message,'Type':i.Type,'Date':i.Date})
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})

def view_check_in_report(request):
    dobj=Checking_report.objects.all()
    l=[]
    for i in dobj:
        l.append({'id':i.id,'checkin_time':i.checkin_time,
                  'checkout_time':i.checkout_time,'Date':i.Date,
                  'STUDENT':i.STUDENT.Name})
    return JsonResponse({'status': 'ok', 'data': l})

def view_check_in_report_parent(request):
    lid=request.POST["lid"]
    dobj=Checking_report.objects.filter(STUDENT__E_mail=login.objects.get(id=lid).username)
    l=[]
    for i in dobj:
        l.append({'id':i.id,'checkin_time':i.checkin_time,
                  'checkout_time':i.checkout_time,'Date':i.Date,
                  'STUDENT':i.STUDENT.Name})
    return JsonResponse({'status': 'ok', 'data': l})


def feeupdation(request):
    pid=request.POST["pid"]

    payment_notification.objects.filter(id=pid).update(Status='Done')

    return JsonResponse({'status':'ok'})



def send_fee_notification(request):
    return render(request,"admin/send fee notification.html")

def send_feenotificationpost(request):
    year= request.POST["year"]
    Month= request.POST["month"]
    Lastdate= request.POST["textfield3"]

    res=student.objects.all()

    for i in res:
        if payment_notification.objects.filter(STUDENT_id=i.id,Month=Month,Year=year).exists():
            continue
        p=payment_notification()
        p.Month= Month
        p.Year= year
        p.Last_date= Lastdate
        p.STUDENT=i
        p.Status="pending"
        p.save()

    return HttpResponse("<script>alert('Fee notification send'); window.location='/myapp/send_fee_notification/'</script>")


def Change_password(request):
    cpass=request.POST["cpass"]
    npass=request.POST["npass"]
    conpass=request.POST["conpass"]
    lid = request.POST['lid']


    login.objects.filter(id=lid).update(password=npass)



    return JsonResponse({'status':'ok'})


