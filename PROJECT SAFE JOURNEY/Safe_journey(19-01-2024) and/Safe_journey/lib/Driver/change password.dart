import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_journey/Driver/driverhome.dart';
import 'package:safe_journey/login.dart';
import 'package:safe_journey/parent/loginmaindemo.dart';
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
      home: const ChangePassword(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.title});



  final String title;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController Current_password=TextEditingController();
  TextEditingController New_password=TextEditingController();
  TextEditingController Confirm_password=TextEditingController();
  final _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child:Form(
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
                  controller: Current_password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Current password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length<8){
                      return 'field must not be <8';
                    }return null;
                  },
                  controller: New_password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'New password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.toString()!=New_password.text){
                      return 'passwords do not match';
                    }return null;
                  },
                  controller: Confirm_password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                if(_formkey.currentState!.validate()){
                  sendData();
                }
                },child: Text('Send'),)
              ),
            ],
          ),
        ),
      ),
    );
  }
  void sendData()async{

    String cpass=Current_password.text;
    String npass=New_password.text;
    String conpass=Confirm_password.text;

    final sh = await SharedPreferences.getInstance();

    String url = sh.getString("url").toString();
    try{
      final response = await http.post(Uri.parse(url+"/myapp/Change_password/"), body: {
        'cpass':cpass,
        'npass':npass,
        'conpass':conpass,
        'lid':sh.getString('lid').toString()

      });
      if(response.statusCode == 200){
        String status = jsonDecode(response.body)['status'];
        if(status == 'ok'){
          Fluttertoast.showToast(msg: "Successfull");
           Navigator.push(context, MaterialPageRoute(builder: (context) => login_new_full(),));

        }else{
          Fluttertoast.showToast(msg: "Not Found");
          Navigator.push(context, MaterialPageRoute(builder: (context) => login_new_full(),));
        }
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => login_new_full(),));
        Fluttertoast.showToast(msg: "Network Error");
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
