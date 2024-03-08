import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safe_journey/theme/colors.dart';
import 'package:icon_badge/icon_badge.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  _DailyPageState(){
    getdata();
    view_childrenfullpages();
    view_buss_allocation();
  }


  int sid_=0;
  String Name_="";
  String Place_="";
  String Post_="";
  String Pin_="";
  String House_name_="";
  String Register_number_="";
  String Gender_="";
  String Phone_number_="";
  String E_mail_="";



  void view_childrenfullpages() async {

    int id = 0;
    String Name = "";
    String Place = "";
    String Post = "";
    String Pin ="";
    String House_name ="";
    String Register_number ="";
    String Gender ="";
    String Phone_number ="";
    String E_mail = "";


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_parent_child1/';
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      // print(arr.length);

      // for (int i = 0; i < arr.length; i++) {
      id=arr['id'];
      Name=arr['Name'];
      Place=arr['Place'];
      Post=arr['Post'];
      Pin=arr['Pin'];
      House_name=arr['House_name'];
      Register_number=arr['Register_number'];
      Gender=arr['Gender'];
      Phone_number=arr['Phone_number'];
      E_mail=arr['E_mail'];

      // }

      setState(() {
        sid_ = id;
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



  int did_=0;
  String busnum_="";
  String bustype_="";
  String driver_="";
  String dpho_="";
  String phone_="";
  String photo_="";






  void view_buss_allocation() async {

    int did = 0;
    String busnum = "";
    String bustype = "";
    String driver = "";
    String dpho ="";
    String phone ="";
    String photo ="";



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_parent_bus1/';
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      // print(arr.length);

      // for (int i = 0; i < arr.length; i++) {
      did=arr['id'];
      busnum=arr['busnum'];
      bustype=arr['bustype'];
      driver=arr['driver'];
      dpho=arr['dpho'];
      phone=arr['phone'];
      photo=arr['photo'];


      // }

      setState(() {
        did_ = did;
        busnum_ = busnum;
        bustype_ = bustype;
        driver_=driver;
        dpho_=dpho;
        phone_=phone;
        photo_=photo;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Profile Info",style: TextStyle(fontWeight: FontWeight.bold,  color: mainFontColor,),), automaticallyImplyLeading: false,),
          body: SingleChildScrollView(
                child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreenAccent.withOpacity(0.05),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 25, right: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Icon(Icons.bar_chart), Icon(Icons.more_vert)
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://banner2.cleanpng.com/20180913/bqs/kisspng-clip-art-student-computer-icons-school-illustratio-5b9af2b9283992.3985997515368813371648.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: (size.width - 40) * 0.6,
                          child: Column(
                            children: [
                              Text(
                                // "Abbie Wilson",
                                Name_,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: mainFontColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                Register_number_,
                                style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.w500,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            // Text(
                            //   Place_,
                            //   style: TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w600,
                            //       color: mainFontColor),
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Text(
                            //   "Pickup",
                            //   style: TextStyle(
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w100,
                            //       color: black),
                            // ),
                          ],
                        ),
                        // Container(
                        //   width: 0.5,
                        //   height: 40,
                        //   color: black.withOpacity(0.3),
                        // ),
                        Column(
                          children: [
                            Text(
                              driver_,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: mainFontColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Driver",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: black),
                            ),
                          ],
                        ),
                        Container(
                          width: 0.5,
                          height: 40,
                          color: black.withOpacity(0.3),
                        ),
                        Column(
                          children: [
                            Text(
                              phone_,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: mainFontColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Contact",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: black),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                           Text("Bus Notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: mainFontColor,
                      )),
                      IconBadge(
          icon: Icon(Icons.notifications_none),
          itemCount: id_.length,
          badgeColor: Colors.red,
          itemColor: mainFontColor,
          hideZero: true,
          top: -1,
          onTap: () {
            print('test');
          },
                ),
                        ],
                      )
                    ],
                  ),
                  // Text("Overview",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20,
                  //       color: mainFontColor,
                  //     )),
                  Text("Jan 16, 2023",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: mainFontColor,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  // padding: EdgeInsets.all(5.0),
                  // shrinkWrap: true,
                  itemCount: id_.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 25,
                          right: 25,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.03),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Container(
                            width: (size.width - 90) * 0.7,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    date_[index],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    name_[index],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    message_[index],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ]),
                          ),
                        ),
                      );
                  },
                ),
              ),

            )
          ],
                ),
              ),
        ));
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
