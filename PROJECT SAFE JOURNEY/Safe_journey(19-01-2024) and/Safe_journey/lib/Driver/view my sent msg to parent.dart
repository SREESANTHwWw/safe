import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_journey/Driver/Driver_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewMySentMsgToParent(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewMySentMsgToParent extends StatefulWidget {
  const ViewMySentMsgToParent({super.key, required this.title});



  final String title;

  @override
  State<ViewMySentMsgToParent> createState() => _ViewMySentMsgToParentState();
}
List<String> list = <String>['On repair', 'Traffic jam', 'Break down'];

class _ViewMySentMsgToParentState extends State<ViewMySentMsgToParent> {
  _ViewMySentMsgToParentState(){
    getdata();
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
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
      String url = '$urls/myapp/view_my_send_message_to_parent/';
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
