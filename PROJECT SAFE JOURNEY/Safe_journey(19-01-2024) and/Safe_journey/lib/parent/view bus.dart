import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
      home: const ViewBus(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewBus extends StatefulWidget {
  const ViewBus({super.key, required this.title});



  final String title;

  @override
  State<ViewBus> createState() => _ViewBusState();
}
List<String> list = <String>['On repair', 'Traffic jam', 'Break down'];

class _ViewBusState extends State<ViewBus> {
  _ViewBusState(){
    view_complaints();
  }
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("View bus"),
      ),
      body: ListView.builder(
        itemCount: id_.length,
        itemBuilder: (context, index) => Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
                padding:  EdgeInsets.all(8.0),
                child: Image(
                  image: NetworkImage(photo_[index])
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bus number'),Text(busnum_[index]),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bus type'),Text(bustype_[index]),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Driver'),Text(driver_[index]),
                  ],
                )
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('phone'),Text(phone_[index]),
                  ],
                )
            ),
 Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(dpho_[index]),radius: 50,)
                  ],
                )
            ),


            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {

                  try{
                    String location='https://maps.google.com/?q='+latitude_[index]+','+longitude_[index];
                    launchUrl(Uri.parse(location));
                  }catch(e){

                  }
                },child: Text('Track'),)
            ),

          ],
        ),
      ),
    );
  }
  List<int> id_=[];
  List<String> busnum_=[];
  List<String> bustype_=[];
  List<String> driver_=[];
  List<String> photo_=[];
  List<String> phone_=[];
  List<String> dpho_=[];
  List<String> latitude_=[];
  List<String> longitude_=[];



  void view_complaints() async {
    List<int> id = <int>[];
    List<String> busnum = <String>[];
    List<String> bustype = <String>[];
    List<String> driver = <String>[];
    List<String> photo = <String>[];
    List<String> phone = <String>[];
    List<String> dpho = <String>[];
    List<String> latitude = <String>[];
    List<String> longitude = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/view_parent_bus/';
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
        busnum.add(arr[i]['busnum']);
        bustype.add(arr[i]['bustype']);
        driver.add(arr[i]['driver']);
        photo.add(urls+arr[i]['photo']);
        dpho.add(urls+arr[i]['dpho']);
        phone.add(arr[i]['phone']);
        latitude.add(arr[i]['latitude_']);
        longitude.add(arr[i]['longitude_']);
      }

      setState(() {
        id_ = id;
        busnum_ = busnum;
        bustype_ = bustype;
        driver_ = driver;
        photo_ = photo;
        phone_ = phone;
        dpho_ = dpho;
        latitude_ = latitude;
        longitude_ = longitude;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }
}
