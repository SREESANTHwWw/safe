

import 'package:flutter/material.dart';
import 'package:safe_journey/Driver/change%20password.dart';
import 'package:safe_journey/Driver/driverviewprofile.dart';
import 'package:safe_journey/Driver/send%20message%20to%20parent.dart';
import 'package:safe_journey/Driver/send%20message.dart';
import 'package:safe_journey/Driver/viesassignedbus2.dart';
import 'package:safe_journey/Driver/view%20assigned%20bus.dart';
import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20adminl.dart';
import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20parent.dart';
import 'package:safe_journey/login.dart';
import 'package:safe_journey/parent/daily_page.dart';
import 'package:safe_journey/parent/loginmaindemo.dart';
import 'package:safe_journey/parent/view%20bus.dart';
import 'package:safe_journey/parent/view%20check%20in%20report.dart';
import 'package:safe_journey/parent/view%20message%20from%20driverl.dart';
import 'package:safe_journey/parent/view%20message%20from%20school.dart';
import 'package:safe_journey/parent/view%20reply.dart';
import 'package:safe_journey/parent/view_children.dart';
import 'package:safe_journey/parent/viewcompletedfeenotification.dart';
import 'package:safe_journey/parent/viewpendingfeenotification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_journey/parent/view%20message%20from%20school.dart';
import 'package:safe_journey/parent/view reply.dart';
import 'package:safe_journey/parent/view reply.dart';

import 'dart:convert';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const student_home(title: 'Register'),
    );
  }
}

class student_home extends StatefulWidget {
  const student_home({super.key, required this.title});


  final String title;

  @override
  State<student_home> createState() => _student_homeState();
}

class _student_homeState extends State<student_home> {
  String photo='';
  String name='';
  String type='';

  String email='email';
  String phone='phone';

  String gender='gender';
  String image='image';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ipunique();
    getdata();
  }

  //stable ip address settings third
  void ipunique() async{
    SharedPreferences s=await SharedPreferences.getInstance();
    photo=s.getString('photo').toString();
    name=s.getString('name').toString();
    type=s.getString('type').toString();

  }



  @override
  Widget build(BuildContext context) {


    return WillPopScope(

      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>student_home (title: '',),));

        return false;

      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 82, 98),


          title: Text(widget.title),
        ),
        body: DailyPage(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 82, 98),
                ),
                child:
                Column(children: [


                  CircleAvatar(radius: 29,backgroundImage: NetworkImage('https://banner2.cleanpng.com/20180913/bqs/kisspng-clip-art-student-computer-icons-school-illustratio-5b9af2b9283992.3985997515368813371648.jpg')),
                  InkWell(
                    onTap: (){
showDialog(context: context, builder: (context) => Image.network('https://banner2.cleanpng.com/20180913/bqs/kisspng-clip-art-student-computer-icons-school-illustratio-5b9af2b9283992.3985997515368813371648.jpg'),);                  },
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),

                    ),
                  ),




                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home',
                style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),

              ListTile(
                leading: Icon(Icons.person_off),
                title: const Text(' Children  '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_childrenfullpage(title: '',),)
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.bus_alert),
                title: const Text('View Bus '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBus(title: 'Bus',),)
                  );
                },
              ),  ListTile(
                leading: Icon(Icons.message),
                title: const Text('View Message From Driver '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMessageFromDriver(),)
                  );
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.school_sharp),
              //   title: const Text('View message from School '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMessageFromSchool(title: 'message',),)
              //     );
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.pending_actions),
                title: const Text('View Fee pending '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewPendingFeewidget(title: 'View Pending Fee'),)
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.check_circle_sharp),
                title: const Text('Completed Fees '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewCompletedFeewidget(title: 'Completed Fees'),)
                  );
                },
              ),ListTile(
                leading: Icon(Icons.playlist_add_check_circle),
                title: const Text('View Checkin & Checkout Report'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>viewcheckinreportfullparent(title: 'View Checkin & Checkout Report'),)
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback_outlined),
                title: const Text('View Complaint '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewReplywidget(title: 'View Reply'),)
                  );
                },
              ),

              // ListTile(
              //   leading: Icon(Icons.person_pin),
              //   title: const Text('ViewMySentMsg parent'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMySentMsgToParent(title: '',),)
              //     );
              //   },
              // ),







              ListTile(
                leading: Icon(Icons.security),
                title: const Text('Change password'),
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(title: 'Change password',),));
                },
              ),






             
   

              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => login_new_full(),));
                },
              ),










            ],
          ),
        ),

      ),
    );
  }


  List<String> id_=[];
  List<String> message_=[];
  List<String> date_=[];
  List<String> type_=[];
  List<String> LOGIN_=[];
  List<String> name_=[];



  void getdata() async {
    List<String> id = <String>[];
    List<String> message = <String>[];
    List<String> date = <String>[];
    List<String> type = <String>[];
    List<String> LOGIN = <String>[];
    List<String> name = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_notification_from_driver_post/';
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      // print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        message.add(arr[i]['Message']);
        date.add(arr[i]['Date'].toString());
        type.add(arr[i]['Type']);
        LOGIN.add(arr[i]['LOGIN'].toString());
        name.add(arr[i]['Name'].toString());
      }

      setState(() {
        id_ = id;
        message_ = message;
        date_ = date;
        type_ = type;
        LOGIN_ = LOGIN;
        name_ = name;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }





}

