import serial
from DBConnection import  Db
serialPort = serial.Serial(port='COM6')


serialString = ""                           # Used to hold data coming over UART
mm=""
counter=0
studentlogid=""
while(True):

        from  datetime import  datetime
        s= datetime.now().strftime("%H:%M:%S")


        serialString = serialPort.read().decode('utf-8')
        mm=mm+serialString
        if len(mm)==12:
            print(mm)
            if counter==0: #first student rfid scanned

                db=Db()
                qry="SELECT * FROM `myapp_student` WHERE `Register_number`='"+mm+"'"
                print(qry)
                mm = ""
                res=db.selectOne(qry)
                if res is not None:

                    import pyttsx3

                    engine = pyttsx3.init()
                    engine.say("Card swiped by student "+ res['Name'])
                    engine.runAndWait()



                    qry="SELECT  * FROM `myapp_checking_report` WHERE `STUDENT_id`='"+str(res['id'])+"' AND `Date`=curdate() order by id DESC"
                    res1= db.select(qry)
                    if len(res1)==0:

                        import pyttsx3

                        engine = pyttsx3.init()
                        engine.say("student " + res['Name']+" checkin")
                        engine.runAndWait()


                        qry="INSERT INTO `myapp_checking_report` (`STUDENT_id`,`checkin_time`,`checkout_time`,`Date`,`status`) VALUES ('"+str(res['id'])+"','"+s+"','pending',curdate(),'checkin')"
                        db.insert(qry)
                    else:
                        res1 = res1[0]

                        if res1['status']=="checkin":

                            import pyttsx3

                            engine = pyttsx3.init()
                            engine.say("student " + res['Name'] + " checkout")
                            engine.runAndWait()


                            qry="update myapp_checking_report set checkout_time='"+s+"', status='checkout' where id='"+str(res1['id'])+"'"
                            db.update(qry)
                        else:

                            import pyttsx3

                            engine = pyttsx3.init()
                            engine.say("student " + res['Name'] + " checkin")
                            engine.runAndWait()


                            qry = "INSERT INTO `myapp_checking_report` (`STUDENT_id`,`checkin_time`,`checkout_time`,`Date`,`status`) VALUES ('" + str(
                                res['id']) + "','" + s + "','pending',curdate(),'checkin')"
                            db.insert(qry)
                else:
                    import pyttsx3

                    engine = pyttsx3.init()
                    engine.say("Card is not valid ")
                    engine.runAndWait()
