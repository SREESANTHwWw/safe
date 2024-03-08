

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:safe_journey/parent/send%20complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewCompletedFee());
}

class ViewCompletedFee extends StatelessWidget {
  const ViewCompletedFee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewCompletedFeewidget(title: 'View Reply'),
    );
  }
}

class ViewCompletedFeewidget extends StatefulWidget {
  const ViewCompletedFeewidget({super.key, required this.title});

  final String title;

  @override
  State<ViewCompletedFeewidget> createState() => _view_complaintState();
}

class _view_complaintState extends State<ViewCompletedFeewidget> {

  _view_complaintState(){
    view_complaints();
  }
  List<int> id_=[];
  List<String> Name_=[];
  List<String> Register_number_=[];
  List<String> Month_=[];
  List<String> Year_=[];
  List<String> Fee_=[];
  List<String> Last_date_=[];



  void view_complaints() async {
    List<int> id = <int>[];
    List<String> Name = <String>[];
    List<String> Register_number = <String>[];
    List<String> Month = <String>[];
    List<String> Year = <String>[];
    List<String> Fee = <String>[];
    List<String> Last_date = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/parentviewcompletedfee/';
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
        Register_number.add(arr[i]['Register_number']);
        Month.add(arr[i]['Month']);
        Year.add(arr[i]['Year']);
        Fee.add(arr[i]['Fee']);
        Last_date.add(arr[i]['Last_date']);
      }

      setState(() {
        id_ = id;
        Name_ = Name;
        Register_number_ = Register_number;
        Month_ = Month;
        Year_ = Year;
        Fee_ = Fee;
        Last_date_ = Last_date;
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
                'Completed Fees',
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
                  child: Container(
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

                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Name_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reg no",
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
                                  "Month",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Month_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Year",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Year_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fee",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Fee_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Last Date",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Last_date_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  )),
            );
          },
        ),



      ),
    );
  }
}
