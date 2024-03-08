

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:safe_journey/parent/parenthome.dart';
import 'package:safe_journey/parent/send%20complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewMessageFromDriver());
}

class ViewMessageFromDriver extends StatelessWidget {
  const ViewMessageFromDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewMessageFromDriverwidget(title: 'View Driver Message'),
    );
  }
}

class ViewMessageFromDriverwidget extends StatefulWidget {
  const ViewMessageFromDriverwidget({super.key, required this.title});

  final String title;

  @override
  State<ViewMessageFromDriverwidget> createState() => _ViewMessageFromDriverwidget();
}

class _ViewMessageFromDriverwidget extends State<ViewMessageFromDriverwidget> {

  _ViewMessageFromDriverwidget(){
    getdata();
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>student_home(title: '',)));
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
                'Messages from driver',
                style: GoogleFonts.poppins(
                  color:Colors.green,
                  fontSize: 17.0,
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
            return ListTile(
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
                                      "Date     : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),  Text(
                                       date_[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Driver: " ,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), Text(
                                       name_[index],
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
                                      "message: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${message_[index]}',
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
            );
          },
        ),



      ),
    );
  }
}
