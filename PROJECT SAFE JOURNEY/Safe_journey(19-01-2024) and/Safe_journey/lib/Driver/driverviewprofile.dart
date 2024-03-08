import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfilePage(title: 'View Profile'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  _ViewProfilePageState()
  {
    _send_data();
  }
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              Column(
                children: [
                  InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context) => Image.network(photo_),);                  },



                      child: Image(image: NetworkImage(photo_),height: 200,width: 200,)),
                  Padding(
                    padding: EdgeInsets.all(5),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name'),
                      Text(name_),
                    ],
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('DOB'),
                        Text(dob_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Gender'),
                        Text(gender_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('E-mail'),
                        Text(email_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Phone number'),
                        Text(phone_number_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Place'),
                        Text(place_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Post'),
                        Text(post_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Pin'),
                        Text(pin_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Experience'),
                        Text(experience_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Licence nubmer'),
                        Text(Licence_number_),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('House name'),
                        Text(House_name_),
                      ],
                    ),
                  ),


                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(
              //       builder: (context) => MyEditPage(title: "Edit Profile"),));
              //   },
              //   child: Text("Edit Profile"),
              // ),

            ],
          ),
        ),
      ),
    );
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
}
