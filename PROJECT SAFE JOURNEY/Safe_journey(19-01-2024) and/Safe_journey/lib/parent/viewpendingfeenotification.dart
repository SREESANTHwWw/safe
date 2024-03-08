

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:safe_journey/parent/send%20complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() {
  runApp(const ViewPendingFee());
}

class ViewPendingFee extends StatelessWidget {
  const ViewPendingFee({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewPendingFeewidget(title: 'View Reply'),
    );
  }
}

class ViewPendingFeewidget extends StatefulWidget {
  const ViewPendingFeewidget({super.key, required this.title});

  final String title;

  @override
  State<ViewPendingFeewidget> createState() => _view_complaintState();
}

class _view_complaintState extends State<ViewPendingFeewidget> {

  late Razorpay _razorpay;
  _view_complaintState(){
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    view_complaints();
  }


  void initState() {
    super.initState();

    // Initializing Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    view_complaints();
  }

  @override
  void dispose() {
    // Disposing Razorpay instance to avoid memory leaks
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Handle successful payment
    print("Payment Successful: ${response.paymentId}");


    final sh = await SharedPreferences.getInstance();

    String url = sh.getString("url").toString();
    String pid = sh.getString("pid").toString();
    try{
      final response = await http.post(Uri.parse(url+"/myapp/feeupdation/"), body: {

        'pid':pid,

      });
      if(response.statusCode == 200){
        String status = jsonDecode(response.body)['status'];
        if(status == 'ok'){

          Fluttertoast.showToast(msg: "Payment done successfully");
          view_complaints();

        }else{
          Fluttertoast.showToast(msg: "Failed to pay");
        }
      }else{
        Fluttertoast.showToast(msg: "Network Error");
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }




  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Error in Payment: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External Wallet: ${response.walletName}");
  }

  void _openCheckout(amt) {
    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': double.parse(amt)*100, // Amount in paise (e.g. 2000 paise = Rs 20)
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the product',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {
        'wallets': ['paytm'] // List of external wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }





  List<int> id_=[];
  List<String> Name_=[];
  List<String> Register_number_=[];
  List<String> Month_=[];
  List<String> Year_=[];
  List<String> Fee_=[];
  List<String> Last_date_=[];



  void view_complaints() async {
    List<int> id = <int>[];
    List<String> Name = <String>[];
    List<String> Register_number = <String>[];
    List<String> Month = <String>[];
    List<String> Year = <String>[];
    List<String> Fee = <String>[];
    List<String> Last_date = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/parentviewpendingfee/';
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
        Name.add(arr[i]['Name']);
        Register_number.add(arr[i]['Register_number']);
        Month.add(arr[i]['Month']);
        Year.add(arr[i]['Year']);
        Fee.add(arr[i]['Fee']);
        Last_date.add(arr[i]['Last_date']);
      }

      setState(() {
        id_ = id;
        Name_ = Name;
        Register_number_ = Register_number;
        Month_ = Month;
        Year_ = Year;
        Fee_ = Fee;
        Last_date_ = Last_date;
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 20.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 1.0,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.green,
                    size: 24.0,
                  ),
                ),
              ),
              Text(
                'Pending Fees',
                style: GoogleFonts.poppins(
                  color:Colors.green,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 40.0,
                child: IconButton(
                  onPressed: () {},
                  splashRadius: 1.0,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 34.0,
                  ),
                ),
              ),
            ],
          ),
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
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    width: 400,
                    child: Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        // color: Colors.orangeAccent,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Name_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reg no",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Register_number_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),


                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Month",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Month_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Year",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Year_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fee",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Fee_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Last Date",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${Last_date_[index]}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),

                            ElevatedButton(onPressed: () async {




                              final sh = await SharedPreferences.getInstance();
                              sh.setString("pid", id_[index].toString());
                                    _openCheckout(Fee_[index]);

                            }, child: Text(
                              'Pay'
                            ))


                          ],
                        ),
                      ),
                    ),
                  )),
            );
          },
        ),



      ),
    );
  }
}
