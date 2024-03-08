import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_journey/Driver/driverhome.dart';
import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20adminl.dart';
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
      home: const MySendMessage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MySendMessage extends StatefulWidget {
  const MySendMessage({super.key, required this.title});



  final String title;

  @override
  State<MySendMessage> createState() => _MySendMessageState();
}

class _MySendMessageState extends State<MySendMessage> {
  TextEditingController message=TextEditingController();
  final _formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Form(
          key: _formkey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty){
                      return 'field must not be empty';
                    }return null;
                  },
                  controller: message,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Message',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                  if(_formkey.currentState!.validate()){
                    sendData();
                  }                },child: Text('Send'),)
              ),
            ],
          ),
        ),
      ),
    );
  }
  void sendData()async{

    String smessage=message.text;

    final sh = await SharedPreferences.getInstance();

    String url = sh.getString("url").toString();
    try{
      final response = await http.post(Uri.parse(url+"/myapp/send_message_to_admin_post/"), body: {
        'message':smessage,
        'lid':sh.getString('lid').toString()

      });
      if(response.statusCode == 200){
        String status = jsonDecode(response.body)['status'];
        if(status == 'ok'){
          Fluttertoast.showToast(msg: "Successfull");
           Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMySentMsgToAdmin(title: ""),));

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
