

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:safe_journey/parent/parenthome.dart';
import 'package:safe_journey/parent/send%20complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewReplywidget(title: 'View Reply'),
    );
  }
}

class ViewReplywidget extends StatefulWidget {
  const ViewReplywidget({super.key, required this.title});

  final String title;

  @override
  State<ViewReplywidget> createState() => _view_complaintState();
}

class _view_complaintState extends State<ViewReplywidget> {

  _view_complaintState(){
    view_complaints();
  }
  List<int> id_=[];
  List<String> complaint_=[];
  List<String> date_=[];
  List<String> reply_=[];
  List<String> status_=[];



  void view_complaints() async {
    List<int> id = <int>[];
    List<String> date = <String>[];
    List<String> complaint = <String>[];
    List<String> reply = <String>[];
    List<String> status = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_reply/';
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
        date.add(arr[i]['Date']);
        complaint.add(arr[i]['Complaint']);
        reply.add(arr[i]['Reply']);
        status.add(arr[i]['Status']);
      }

      setState(() {
        id_ = id;
        date_ = date;
        complaint_ = complaint;
        reply_ = reply;
        status_ = status;
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
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => student_home(title: ''),));
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
                'View Replies',
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
                                   date_[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Complaint: ",
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width-100,
                                  child: ReadMoreText(
                                    complaint_[index],
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),

                                SizedBox(height: 8),
                                Text(
                                  "Reply         : ",
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ),
                                ),Container(
                                  width: MediaQuery.of(context).size.width-100,
                                  child: ReadMoreText(
                                    reply_ [index],
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',lessStyle: TextStyle(color: Colors.blue),
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blue),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Status       : " + status_[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: status_[index] == "replied"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
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
        floatingActionButton: FloatingActionButton(onPressed: () {

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SendComplaint(title: 'Reply',)));

        },
          child: Icon(Icons.add),
        ),


      ),
    );
  }
}
