

import 'package:flutter/material.dart';
import 'package:safe_journey/Driver/change%20password.dart';
import 'package:safe_journey/Driver/driverviewprofile.dart';
import 'package:safe_journey/Driver/send%20message%20to%20parent.dart';
import 'package:safe_journey/Driver/send%20message.dart';
import 'package:safe_journey/Driver/viesassignedbus2.dart';
import 'package:safe_journey/Driver/view%20assigned%20bus.dart';
import 'package:safe_journey/Driver/view%20check%20in%20report.dart';
import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20adminl.dart';
import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20parent.dart';
import 'package:safe_journey/const.dart';
import 'package:safe_journey/login.dart';
import 'package:safe_journey/parent/loginmaindemo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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
      title: 'Clean',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserHomePage(title: 'Register'),
    );
  }
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key, required this.title});


  final String title;

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String photo='';
  String name='';
  String type='';

  String email='email';
  String phone='phone';

  String gender='gender';
  String image='image';

  _UserHomePageState()
  {
    ipunique();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ipunique();
    // senddata();
    _send_data();
  }

  //stable ip address settings third
  void ipunique() async{
    SharedPreferences s=await SharedPreferences.getInstance();
    photo=s.getString('photo').toString();
    name=s.getString('name').toString();
    type=s.getString('type').toString();
    String imgurl=s.getString('url').toString();

    setState(() {
      photo=imgurl+photo;
      name=name;
    });

  }

  String name_="";
  String dob_="";
  String gender_="";
  String email_="";
  String phone_number_="";
  String place_="";
  String post_="";
  String pin_="";
  String experience_="";
  String Licence_number_="";
  String photo_="";
  String House_name_="";


  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/view_driver_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)['Name'].toString();
          String Place=jsonDecode(response.body)['Place'].toString();
          String Post=jsonDecode(response.body)['Post'].toString();
          String Pin=jsonDecode(response.body)['Pin'].toString();
          String House_name=jsonDecode(response.body)['House_name'].toString();
          String Phone_number=jsonDecode(response.body)['Phone_number'].toString();
          String E_mail=jsonDecode(response.body)['E_mail'].toString();
          String Experience=jsonDecode(response.body)['Experience'].toString();
          String Licence_number=jsonDecode(response.body)['Licence_number'].toString();
          String photo=baseUrl+jsonDecode(response.body)['photo'].toString();
          String DOB=jsonDecode(response.body)['DOB'].toString();
          String Gender=jsonDecode(response.body)['Gender'].toString();

          setState(() {

            name_= name;
            dob_= DOB;
            gender_= Gender;
            email_= E_mail;
            phone_number_= Phone_number;
            place_= Place;
            post_= Post;
            pin_= Pin;
            House_name_= House_name;
            experience_=Experience;
            Licence_number_=Licence_number;
            photo_= photo;
          });





        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {


    return WillPopScope(

      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>UserHomePage (title: '',),));

        return false;

      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 82, 98),


          title: Text(widget.title),
        ),
        body:
        SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                // child: Image.network(
                //   photo_,
                //   fit: BoxFit.fill,
                // ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            ' $name_',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          // Text(
                                          //   '$email',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyText1,
                                          // ),
                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Spacer(),

                                    ],
                                  )),
                              SizedBox(height: 10.0),
                              Row(
                                children: [

                                ],
                              ),
                            ],
                          ),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     showDialog(context: context, builder: (context) => Image.network(photo_),);
                        //   },
                        //   child: Container(
                        //     height: 90,
                        //     width: 90,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(20.0),
                        //         image:  DecorationImage(
                        //             image: NetworkImage(
                        //                 photo_),
                        //             fit: BoxFit.cover)),
                        //     margin: EdgeInsets.only(left: 20.0),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children:  [
                          ListTile(
                            title: Text("Profile Information"),
                          ),
                          Divider(),
                          // ListTile(
                          //   title: Text("Date of Birth"),
                          //   subtitle: Text("12 September 2001"),
                          //   leading: Icon(Icons.calendar_view_day),
                          // ),
                          // ListTile(
                          //   title: Text('Qualifiactaion'),
                          //   subtitle: Text("Bachelor Degree"),
                          //   leading: Icon(Icons.school_outlined),
                          // ),


                          ListTile(
                            title: Text("Dob"),
                            subtitle: Text('$dob_'),
                            leading: Icon(Icons.date_range),
                          ),
                          ListTile(
                            title: Text("Gender"),
                            subtitle: Text('$gender_'),
                            leading: Icon(Icons.male_sharp),
                          ),
                          ListTile(
                            title: Text('Email'),
                            subtitle: Text(email_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text('Phone number'),
                            subtitle: Text(phone_number_),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text('Place'),
                            subtitle: Text(place_),
                            leading: Icon(Icons.place),
                          ),
                          ListTile(
                            title: Text('Post'),
                            subtitle: Text(post_),
                            leading: Icon(Icons.post_add_sharp),
                          ),
                          ListTile(
                            title: Text('Pin'),
                            subtitle: Text(pin_),
                            leading: Icon(Icons.pin),
                          ),
                          ListTile(
                            title: Text("House name"),
                            subtitle: Text(House_name_),
                            leading: Icon(Icons.house),
                          ),
                          ListTile(
                            title: Text("Experience"),
                            subtitle: Text(experience_),
                            leading: Icon(Icons.add_chart),
                          ),
                          ListTile(
                            title: Text("Licence number"),
                            subtitle: Text(Licence_number_),
                            leading: Icon(Icons.car_repair),
                          ),




                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Positioned(
              //   top: 60,
              //   left: 20,
              //   child: MaterialButton(
              //     minWidth: 0.2,
              //     elevation: 0.2,
              //     color: Colors.white,
              //     child: const Icon(Icons.arrow_back_ios_outlined,
              //         color: Colors.indigo),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //     onPressed: () {
              //
              //       Navigator.push(context, MaterialPageRoute(builder: (context) =>UserHomePage (title: 'Home',),));
              //
              //
              //
              //     },
              //   ),
              // ),
            ],
          ),
        ),
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


                  CircleAvatar(radius: 29,backgroundImage: NetworkImage(image)),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),

                  ),




                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),


              ListTile(
                leading: Icon(Icons.directions_bus_sharp),
                title: const Text('View assigned bus '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewAssignedBus (title: '',),)
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: const Text('Send message to admin '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MySendMessage(title: '',),)
                  );
                },

              ),

              ListTile(
                leading: Icon(Icons.messenger_outlined),
                title: const Text('View message to admin '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMySentMsgToAdmin(title: '',),)
                  );
                },
              ),


               ListTile(
                leading: Icon(Icons.message_outlined),
                title: const Text('Send message to parent '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SendMessageToParent(title: '',),)
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.messenger_outline),
                title: const Text('View my message to parent'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMySentMsgToParent(title: '',),)
                  );
                },
              ),


              ListTile(
                leading: Icon(Icons.report_gmailerrorred),
                title: const Text('View check in report '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewcheckinreportfull(title: 'Checking Report',),)
                  );
                },
              ),






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
















  void senddata()async{



    SharedPreferences sh=await SharedPreferences.getInstance();
    String url=sh.getString('url').toString();
    String lid=sh.getString('lid').toString();
    final urls=Uri.parse(url+"/user_profile_new/");
    try{
      final response=await http.post(urls,body:{
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {


          setState(() {
            email=jsonDecode(response.body)['email'];
            name=jsonDecode(response.body)['name'];
            phone=jsonDecode(response.body)['phone'];


            image=sh.getString('imgurl').toString()+jsonDecode(response.body)['image'];



          });

        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }



}

