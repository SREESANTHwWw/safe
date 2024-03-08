// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ViewAssignedBus(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class ViewAssignedBus extends StatefulWidget {
//   const ViewAssignedBus({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<ViewAssignedBus> createState() => _ViewAssignedBusState();
// }
// List<String> list = <String>['On repair', 'Traffic jam', 'Break down'];
//
// class _ViewAssignedBusState extends State<ViewAssignedBus> {
//   String dropdownValue = list.first;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//             Padding(
//                 padding:  EdgeInsets.all(8.0),
//                 child: Image(
//                   image: NetworkImage(''),errorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/schlbus.jpg')),
//                 )
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Bus number'),Text('1'),
//                 ],
//               )
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Bus type'),Text('van'),
//                   ],
//                 )
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Total seat'),Text('36'),
//                   ],
//                 )
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Chasis number'),Text('4532'),
//                   ],
//                 )
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('Vehicle status'),
//                   SizedBox(width: 50,),
//                   Container(width: MediaQuery.of(context).size.width-200,
//                     child: DropdownButton<String>(
//                       isExpanded: true,
//                       value: dropdownValue,
//                       icon: const Icon(Icons.arrow_downward),
//                       elevation: 16,
//                       style: const TextStyle(color: Colors.deepPurple),
//                       underline: Container(
//                         height: 2,
//                         color: Colors.deepPurpleAccent,
//                       ),
//                       onChanged: (String? value) {
//                         // This is called when the user selects an item.
//                         setState(() {
//                           dropdownValue = value!;
//                         });
//                       },
//                       items: list.map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               )
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(onPressed: () {
//
//               },child: Text('Update'),)
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   String id_="", Bus_number_="",Bus_type_="",Total_seat_="",Photo_="",Chasis_number_="",DRIVER_id_="";
//   void getData()async{
//     String id="", Bus_number="",Bus_type="",Total_seat="",Photo="",Chasis_number="",DRIVER_id="";
//
//     final sh = await SharedPreferences.getInstance();
//
//     String url = sh.getString("url").toString();
//     try{
//       final response = await http.post(Uri.parse(url+"/myapp/send_message_to_admin_post/"), body: {
//         'lid':sh.getString("lid").toString(),
//       });
//       if(response.statusCode == 200){
//         String status = jsonDecode(response.body)['status'];
//         if(status == 'ok'){
//           // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAssignedBus(title: "Home"),));
//
//         }else{
//           Fluttertoast.showToast(msg: "Not Found");
//         }
//       }else{
//         Fluttertoast.showToast(msg: "Network Error");
//       }
//     }catch(e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }
