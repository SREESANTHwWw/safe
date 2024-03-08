

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:safe_journey/parent/send%20complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const viewcheckinreport());
}

class viewcheckinreport extends StatelessWidget {
  const viewcheckinreport({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checking Report',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const viewcheckinreportfull(title: 'Checking Report'),
    );
  }
}

class viewcheckinreportfull extends StatefulWidget {
  const viewcheckinreportfull({super.key, required this.title});

  final String title;

  @override
  State<viewcheckinreportfull> createState() => _view_complaintState();
}

class _view_complaintState extends State<viewcheckinreportfull> {

  _view_complaintState(){
    view_complaints();
  }
  List<int> id_=[];
  List<String> checkin_time_=[];
  List<String> Date_=[];
  List<String> checkout_time_=[];
  List<String> STUDENT_=[];



  void view_complaints() async {
    List<int> id = <int>[];
    List<String> checkin_time = <String>[];
    List<String> checkout_time = <String>[];
    List<String> Date = <String>[];
    List<String> STUDENT = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_check_in_report/';
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
        checkin_time.add(arr[i]['checkin_time']);
        checkout_time.add(arr[i]['checkout_time']);
        Date.add(arr[i]['Date']);
        STUDENT.add(arr[i]['STUDENT']);
      }

      setState(() {
        id_ = id;
        checkout_time_ = checkout_time;
        checkin_time_ = checkin_time;
        Date_ = Date;
        STUDENT_ = STUDENT;
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
                'Checkin Report',
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
                                Text(
                                  Date_[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "STUDENT NAME: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${STUDENT_[index]}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ), SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Checkin time: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${checkin_time_[index]}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Checkout time         : ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${checkout_time_[index]}',
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
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => SendComplaint(title: 'Reply',)));
        //
        // },
        //   child: Icon(Icons.add),
        // ),


      ),
    );
  }
}
