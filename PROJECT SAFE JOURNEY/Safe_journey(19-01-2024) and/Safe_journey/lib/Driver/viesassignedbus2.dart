import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:safe_journey/Driver/Driver_home.dart';
import 'package:safe_journey/Driver/view%20assigned%20bus.dart';
import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20adminl.dart';
import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20parent.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const viewAsign());
}

class viewAsign extends StatelessWidget {
  const viewAsign({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewAssignedBus(title: 'View Reply'),
    );
  }
}

class ViewAssignedBus extends StatefulWidget {
  const ViewAssignedBus({super.key, required this.title});

  final String title;

  @override
  State<ViewAssignedBus> createState() => _ViewAssignedBusState();
}

class _ViewAssignedBusState extends State<ViewAssignedBus> {
  String dropdownValue = list.first;


  _ViewAssignedBusState(){
    viewAsign();
  }

  List<String> id_ = <String>[];
  List<String> Bus_number_= <String>[];
  List<String> Bus_type_= <String>[];
  List<String> Total_seat_= <String>[];
  List<String> Photo_= <String>[];

  Future<void> viewAsign() async {
    List<String> id = <String>[];
    List<String> Bus_number = <String>[];
    List<String> Bus_type = <String>[];
    List<String> Total_seat = <String>[];
    List<String> Photo = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/view_assigned_bus/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        Bus_number.add(arr[i]['Bus_number'].toString());
        Bus_type.add(arr[i]['Bus_type'].toString());
        Total_seat.add(arr[i]['Total_seat'].toString());
        Photo.add(sh.get('img_url').toString()+arr[i]['Photo'].toString());
      }

      setState(() {
        id_ = id;
        Bus_number_ = Bus_number;
        Bus_type_ = Bus_type;
        Total_seat_ = Total_seat;
        Photo_ = Photo;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }





  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserHomePage(title: '',)),);

          },),
          backgroundColor: Theme.of(context).colorScheme.primary,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child:
                    Column(
                      children: [
                        // Padding(
                        //     padding:  EdgeInsets.all(8.0),
                        //     child: Image(
                        //       image: NetworkImage(''),errorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/schlbus.jpg')),
                        //     )
                        // ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bus number'),Text(Bus_number_[index]),
                              ],
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bus type'),Text(Bus_type_[index]),
                              ],
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total seat'),Text(Total_seat_[index]),
                              ],
                            )
                        ),

                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Vehicle status'),
                                SizedBox(width: 50,),
                                Container(width: MediaQuery.of(context).size.width-250,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),


                                ),
                              ],
                            )
                        ),

                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: () {
                              sendData();
                            },child: Text('Send'),)
                        ),

                      ],
                    ),

                    elevation: 8,
                    margin: EdgeInsets.all(10),
                  )),
            );
          },
        ),
       // floatingActionButton: FloatingActionButton(onPressed: () {
       //
       //   Navigator.push(
       //       context,
       //       MaterialPageRoute(builder: (context) => MySendComplaint()));
       //
       // },
       //   child: Icon(Icons.plus_one),
       // ),


      ),
    );
  }


  void sendData()async{

    String dropdownValue1=dropdownValue;

    final sh = await SharedPreferences.getInstance();

    String url = sh.getString("url").toString();
    try{
      final response = await http.post(Uri.parse(url+"/myapp/send_message_to_admin_post/"), body: {
        'message':dropdownValue1,
        'lid':sh.getString('lid').toString()

      });
      if(response.statusCode == 200){
        String status = jsonDecode(response.body)['status'];
        if(status == 'ok'){
          Fluttertoast.showToast(msg: "Successfull");
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(title: "Home"),));

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
