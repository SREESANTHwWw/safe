import 'dart:convert';

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
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewPaymentAlert(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewPaymentAlert extends StatefulWidget {
  const ViewPaymentAlert({super.key, required this.title});



  final String title;

  @override
  State<ViewPaymentAlert> createState() => _ViewPaymentAlertState();
}
List<String> list = <String>['On repair', 'Traffic jam', 'Break down'];

class _ViewPaymentAlertState extends State<ViewPaymentAlert> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(''),
      ),
      body: ListView.builder(itemCount: 2,
        itemBuilder: (context, index) => Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Month'),Text('March'),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fee'),Text('2000'),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Last date'),Text('05-05-2024'),
                  ],
                )
            ),





          ],
        ),
      ),
    );
  }
  List id_ = [], Month_=[], Fee_=[], Lastdate_=[],Status_=[],ALLOCATION_id_=[];
  void getData()async{
    List id = [], Month=[], Fee=[], Lastdate=[],Status=[],ALLOCATION_id=[];

    final sh = await SharedPreferences.getInstance();

    String url = sh.getString("url").toString();
    try{
      final response = await http.post(Uri.parse(url+"/myapp/send_message_to_admin_post/"), body: {
        'lid':sh.getString("lid").toString(),
      });
      if(response.statusCode == 200){
        String status = jsonDecode(response.body)['status'];
        if(status == 'ok'){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPaymentAlert(title: "Home"),));

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
}
