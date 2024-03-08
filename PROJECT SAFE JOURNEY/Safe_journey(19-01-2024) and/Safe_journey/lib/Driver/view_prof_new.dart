import 'package:flutter/services.dart';


import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_journey/Driver/Driver_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      // title: '',
      // theme: ThemeData(
      //
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // home:  (title: 'Sent Complaint'),
    );
  }
}


class userProfile_new1 extends StatefulWidget {
  const userProfile_new1({super.key, required this.title});


  final String title;

  @override
  State<userProfile_new1> createState() => _userProfile_new1State();
}
class _userProfile_new1State extends State<userProfile_new1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _send_data();
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
        'Name':name_,
        'Place':place_,
        'Post':post_,
        'Pin':pin_,
        'House_name':House_name_,
        'Phone_number':phone_number_,
        'E_mail':email_,
        'Experience':experience_,
        'Licence_number':Licence_number_,
        'photo':photo_,
        'DOB':dob_,
        'Gender':gender_,


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
          String photo=url+jsonDecode(response.body)['photo'].toString();
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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => UserHomePage(title: 'Home',),));
        return false;

      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 18, 82, 98),
        //
        //   title: Text("Change Password",
        //       style: TextStyle(
        //           color: Color.fromARGB(255, 255, 255, 255)
        //       )),
        // ),
        body:


        SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  photo_,
                  fit: BoxFit.fill,
                ),
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
                                            ' $photo_',
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
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image:  DecorationImage(
                                  image: NetworkImage(
                                      photo_),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 20.0),
                        ),
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
                            title: Text("name"),
                            subtitle: Text('$name_'),
                            leading: Icon(Icons.male_sharp),
                          ),
                          ListTile(
                            title: Text("dob"),
                            subtitle: Text('$dob_'),
                            leading: Icon(Icons.date_range),
                          ),
                          ListTile(
                            title: Text("gender"),
                            subtitle: Text('$gender_'),
                            leading: Icon(Icons.male_sharp),
                          ),
                          ListTile(
                            title: Text('email'),
                            subtitle: Text(email_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text('phone number'),
                            subtitle: Text(phone_number_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text('place'),
                            subtitle: Text(place_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text('post'),
                            subtitle: Text(post_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text('pin'),
                            subtitle: Text(pin_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text("House name"),
                            subtitle: Text(House_name_),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("experience"),
                            subtitle: Text(experience_),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("Licence number"),
                            subtitle: Text(Licence_number_),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("photo"),
                            subtitle: Text(photo_),
                            leading: Icon(Icons.phone),
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
      ),
    );
  }




}