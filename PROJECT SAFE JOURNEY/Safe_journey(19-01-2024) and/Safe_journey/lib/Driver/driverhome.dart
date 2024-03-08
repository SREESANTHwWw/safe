// import 'package:flutter/material.dart';
// import 'package:safe_journey/Driver/send%20message%20to%20parent.dart';
// import 'package:safe_journey/Driver/send%20message.dart';
// import 'package:safe_journey/Driver/viesassignedbus2.dart';
// import 'package:safe_journey/Driver/view%20assigned%20bus.dart';
// import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20adminl.dart';
// import 'package:safe_journey/Driver/view%20my%20sent%20msg%20to%20parent.dart';
// import 'package:safe_journey/Driver/view%20profile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:safe_journey/login.dart';
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
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController ip=TextEditingController();
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
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(onPressed: () async{
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => MySendMessage(title: "Send"),));
//
//               },child: Text('Send message to admin'),)
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(onPressed: () async{
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SendMessageToParent(title: "Send"),));
//
//                 },child: Text('Send message to parent'),)
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(onPressed: () async{
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAssignedBus(title: "View"),));
//
//                 },child: Text('View assigned bus'),)
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(onPressed: () async{
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMySentMsgToAdmin(title: "View"),));
//
//                 },child: Text('View my sent msg to admin'),)
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(onPressed: () async{
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMySentMsgToParent(title: "View"),));
//
//                 },child: Text('View my sent msg to parent'),)
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(onPressed: () async{
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewProfile(title: "View"),));
//
//                 },child: Text('View profile'),)
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
