





import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:safe_journey/Driver/Driver_home.dart';
import 'package:safe_journey/parent/send%20complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewMySentMsgT());
}

class ViewMySentMsgT extends StatelessWidget {
  const ViewMySentMsgT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View message',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewMySentMsgToAdmin(title: 'View Reply'),
    );
  }
}

class ViewMySentMsgToAdmin extends StatefulWidget {
  const ViewMySentMsgToAdmin({super.key, required this.title});

  final String title;

  @override
  State<ViewMySentMsgToAdmin> createState() => _view_complaintState();
}

class _view_complaintState extends State<ViewMySentMsgToAdmin> {

  _view_complaintState(){
    view_complaints();
  }
  List<int> id_=[];
  List<String> Message_=[];
  List<String> Type_=[];
  List<String> Date_=[];


  void view_complaints() async {
    List<int> id = <int>[];
    List<String> Type = <String>[];
    List<String> Message = <String>[];
    List<String> Date = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_message_to_admin/';
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
        Type.add(arr[i]['Type']);
        Message.add(arr[i]['Message']);
        Date.add(arr[i]['Date']);}

      setState(() {
        id_ = id;
        Type_ = Type;
        Message_ = Message;
        Date_ = Date;});

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }







  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(title: ''),));
        return false;
      },
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(title: ''),));
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
                'message',
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
                                 Text(
                                   Type_[index],
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
                                      "Message: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${Message_[index]}',
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


