import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      // // title: 'Flutter Demo',
      // // theme: ThemeData(
      // //
      // //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // //   useMaterial3: true,
      // ),
      home: const MyViewProfile(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyViewProfile extends StatefulWidget {
  const MyViewProfile({super.key, required this.title});



  final String title;

  @override
  State<MyViewProfile> createState() => _MyViewProfileState();
}
List<String> list = <String>['On repair', 'Traffic jam', 'Break down'];

class _MyViewProfileState extends State<MyViewProfile> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: SingleChildScrollView(
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          
              Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(''),errorBuilder: (context, error, stackTrace) => Image(image: AssetImage(Photo_)),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name'),Text(name_),
                  ],
                )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('DOB'),Text(dob_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gender'),Text(gender_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Place'),Text(Place_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Post'),Text(post_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pin'),Text(pin_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('House Name'),Text(House_name_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phone number'),Text(phone_number_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('E_mail'),Text(Email_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Experience'),Text(experience_),
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Licence number'),Text(licence_number_),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
          
                },child: Text('Update'),)
              ),
            ],
          ),
        ),
      ),
    );
  }
  String id_="", Name_="",DOB_="",Gender_="",Place_="",Post_="",Pin_="",House_Name_="",Phone_number_="",E_mail_="",Experience_="",Licence_number_="";
  void getData()async{
    String id="", Name="",DOB="",Gender="",Place="",Post="",Pin="",House_Name="",Phone_number="",E_mail="",Experience="",Licence_number="";

    final sh = await SharedPreferences.getInstance();

    String url = sh.getString("url").toString();
    try{
      final response = await http.post(Uri.parse(url+"/myapp/view_driver_profile/"), body: {
        'lid':sh.getString("lid").toString(),
      });
      if(response.statusCode == 200){
        String status = jsonDecode(response.body)['status'];
        if(status == 'ok'){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewProfile(title: "Home"),));

        }else{
          Fluttertoast.showToast(msg: "Not Found");
        }
      }else{
        Fluttertoast.showToast(msg: "Network Error");
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  String name_="";
  String place_="";
  String post_="";
  String pin_="";
  String House_name_="";
  String phone_number_="";
  String Email_="";
  String experience_="";
  String licence_number_="";
  String Photo_="";
  String dob_="";
  String gender_="";


  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/user_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'Name':name_,
        'Place':place_,
        'Post':post_,
        'Pin':pin_,
        'House_name':House_name_,
        'Phone_number':phone_number_,
        'E_mail':Email_,
        'Experience':experience_,
        'Licence_number':licence_number_,
        'photo':Photo_,
        'DOB':dob_,
        'Gender':gender_,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)["name"];
          String place=jsonDecode(response.body)["place"];
          String post=jsonDecode(response.body)["post"];
          String pin=jsonDecode(response.body)["pin"];
          String House_name=jsonDecode(response.body)["House_name"];
          String phone_number=jsonDecode(response.body)["phone_number"];
          String Email=jsonDecode(response.body)["Email"];
          String experience=jsonDecode(response.body)["experience"];
          String licence_number=jsonDecode(response.body)["licence_number"];
          String Photo=url+jsonDecode(response.body)["Photo"];
          String dob=jsonDecode(response.body)["dob"];
          String gender=jsonDecode(response.body)["gender"];


          setState(() {

            name_= name;
            place_= place;
            post_= post;
            pin_= pin;
            House_name_=House_name;
            phone_number_= phone_number;
            Email_= Email;
            experience_= experience;
            licence_number_= licence_number;
            Photo_= Photo;
            dob_= dob;
            gender_= gender;


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

  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('Licence_number', Licence_number_));
  }
}


