import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_journey/Driver/Driver_home.dart';
import 'package:safe_journey/Driver/driverhome.dart';
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
      home: const LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController uname = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: uname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot password?'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  sendData();
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendData() async {
    String sname = uname.text;
    String spassword = password.text;

    final sh = await SharedPreferences.getInstance();

    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    try {
      final response =
          await http.post(Uri.parse(url + "/myapp/Login__post/"), body: {
        'uname': sname,
        'password': spassword,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        String type = jsonDecode(response.body)['type'];

        if (status == 'ok') {
          if (type == 'driver') {
            String photo = sh.getString("imgurl").toString() +
                jsonDecode(response.body)['photo'];
            // String name=jsonDecode(response.body)['name'];
            // sh.setString("photo", photo);
            // sh.setString("name", name);
            sh.setString("type", type);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHomePage(title: "Home"),
                ));
          }
        } else {
          Fluttertoast.showToast(msg: "Not Found");
        }
      } else {
        Fluttertoast.showToast(msg: "Network Error");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
