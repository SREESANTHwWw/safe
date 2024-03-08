import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:safe_journey/Driver/Driver_home.dart';
import 'package:safe_journey/parent/parenthome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home: login_new_full(),
    );
  }
}

class login_new_full extends StatefulWidget {
  login_new_full({
    Key? key,
  }) : super(key: key);

  @override
  State<login_new_full> createState() => _LoginState();
}

class _LoginState extends State<login_new_full> {
  _LoginState() {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ltype = sh.getString('ltype').toString();
      if (ltype == 'driver') {
        updatelocation();
        updatebackgroundlocation();
      }
    });
  }

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyIpPage(),
              
    
            ));

      final sh = await SharedPreferences.getInstance();
      sh.setString('url', 'http://127.0.0.1:8000');
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400
            ])),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1300),
                            child: Text(
                              "Welcome Back",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            FadeInUp(
                                duration: Duration(milliseconds: 1400),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Color.fromRGBO(225, 95, 27, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200))),
                                        child: TextFormField(
                                          controller: _controllerUsername,
                                          decoration: InputDecoration(
                                              hintText: "Email or Phone number",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                          onEditingComplete: () =>
                                              _focusNodePassword.requestFocus(),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Email or Phone number.";
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200))),
                                        child: TextFormField(
                                          controller: _controllerPassword,
                                          focusNode: _focusNodePassword,
                                          obscureText: _obscurePassword,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter password.";
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )),

                            SizedBox(
                              height: 40,
                            ),
                            FadeInUp(
                                duration: Duration(milliseconds: 1600),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      senddata();
                                    }
                                  },
                                  height: 50,
                                  // margin: EdgeInsets.symmetric(horizontal: 50),
                                  color: Colors.orange[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  // decoration: BoxDecoration(
                                  // ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            // SizedBox(height: 40,),
                            // FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Don't have an account?", style: TextStyle(color: Colors.grey),)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Location location = new Location();

  void updatelocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        latitude = currentLocation.latitude.toString();
        longitude = currentLocation.longitude.toString();
      });
    });

    // setState(() {
    //
    //   latitude=_locationData.latitude.toString();
    //   longitude=_locationData.longitude.toString();
    // });
  }

  String latitude = '';
  String longitude = '';

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void updatebackgroundlocation() async {
    String latitude_ = latitude;
    String longitude_ = longitude;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse(url + "/myapp/update_location/");

    try {
      final response = await http.post(urls, body: {
        'latitude': latitude_,
        'longitude': longitude_,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void senddata() async {
    String username = _controllerUsername.text;
    String password = _controllerPassword.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse(url + "/myapp/Login__post/");

    try {
      final response = await http.post(urls, body: {
        'uname': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Success');
          String type = jsonDecode(response.body)['type'];

          String lid = jsonDecode(response.body)['lid'].toString();
          sh.setString("lid", lid);
          if (type == 'driver') {
            setState(() {
              sh.setString("ltype", type);
              _LoginState();
            });

            String photo = jsonDecode(response.body)['photo'];
            String name = jsonDecode(response.body)['name'];
            sh.setString("photo", photo);
            sh.setString("name", name);
            sh.setString("type", type);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHomePage(title: "Home"),
                ));
          }
          if (type == 'parent') {
            sh.setString("ltype", type);

            // String photo=sh.getString("imgurl").toString()+jsonDecode(response.body)['photo'];
            String name = jsonDecode(response.body)['name'];
            // sh.setString("photo", photo);
            sh.setString("name", name);
            sh.setString("type", type);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => student_home(title: "Home"),
                ));
          }
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Please enter a User Name';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a Password';
    }
    return null;
  }
}
