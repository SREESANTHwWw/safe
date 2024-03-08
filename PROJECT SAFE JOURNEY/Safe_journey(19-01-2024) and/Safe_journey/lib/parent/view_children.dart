

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:safe_journey/parent/send%20complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const view_childrenf());
}

class view_childrenf extends StatelessWidget {
  const view_childrenf({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const view_childrenfullpage(title: 'View Reply'),
    );
  }
}

class view_childrenfullpage extends StatefulWidget {
  const view_childrenfullpage({super.key, required this.title});

  final String title;

  @override
  State<view_childrenfullpage> createState() => _view_childrenfullpageState();
}

class _view_childrenfullpageState extends State<view_childrenfullpage> {

  _view_childrenfullpageState(){
    view_childrenfullpages();
  }
  List<int> id_=[];
  List<String> Name_=[];
  List<String> Place_=[];
  List<String> Post_=[];
  List<String> Pin_=[];
  List<String> House_name_=[];
  List<String> Register_number_=[];
  List<String> Gender_=[];
  List<String> Phone_number_=[];
  List<String> E_mail_=[];



  void view_childrenfullpages() async {
    List<int> id = <int>[];
    List<String> Name = <String>[];
    List<String> Place = <String>[];
    List<String> Post = <String>[];
    List<String> Pin = <String>[];
    List<String> House_name = <String>[];
    List<String> Register_number = <String>[];
    List<String> Gender = <String>[];
    List<String> Phone_number = <String>[];
    List<String> E_mail = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_parent_child/';
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      // print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id']);
        Name.add(arr[i]['Name']);
        Place.add(arr[i]['Place']);
        Post.add(arr[i]['Post']);
        Pin.add(arr[i]['Pin']);
        House_name.add(arr[i]['House_name']);
        Register_number.add(arr[i]['Register_number']);
        Gender.add(arr[i]['Gender']);
        Phone_number.add(arr[i]['Phone_number']);
        E_mail.add(arr[i]['E_mail']);

      }

      setState(() {
        id_ = id;
        Name_ = Name;
        Place_ = Place;
        Post_=Post;
        Pin_=Pin;
        House_name_=House_name;
        Register_number_=Register_number;
        Gender_=Gender;
        Phone_number_=Phone_number;
        E_mail_=E_mail;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }







  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },

      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 20.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 1.0,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.green,
                    size: 24.0,
                  ),
                ),
              ),
              Text(
                'Children',
                style: GoogleFonts.poppins(
                  color:Colors.green,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 40.0,
                child: IconButton(
                  onPressed: () {},
                  splashRadius: 1.0,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 34.0,
                  ),
                ),
              ),
            ],
          ),
        ),

        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListTile(
                onLongPress: () {
                  print("long press" + index.toString());
                },
                title: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(

                      children: [
                        Container(
                          width: 400,
                          child: Card(
                            elevation: 6,
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              // color: Colors.orangeAccent,
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Name: ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),     Text(
                                       Name_[index],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Place: ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${Place_[index]}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
              
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Post: ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${Post_[index]}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
              
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pin : ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${Pin_[index]}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "House Name : ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${House_name_[index]}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Phone Number: ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${Phone_number_[index]}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "EmailId : ",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      '${E_mail_[index]}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                                    SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Register Number : ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${Register_number_[index]}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gender  : ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${Gender_[index]}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                                ],
                              ),
                            ),
                          ),
                        ),
              
              
              
              
                      ],
                    )),
              ),
            );
          },
        ),



      ),
    );
  }
}
