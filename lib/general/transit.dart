import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:newama2/general/dispatch.dart';
import 'package:newama2/general/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransitPage extends StatefulWidget {
  String orderno;
  String outlet;
  String status;
  String rider;
  TransitPage(
      {super.key,
      required this.orderno,
      required this.outlet,
      required this.status,
      required this.rider});

  @override
  State<TransitPage> createState() =>
      _TransitPageState(orderno, outlet, status, rider);
}

class _TransitPageState extends State<TransitPage> {
  String orderno;
  String outlet;
  String status;
  String rider;
  List thisOrder = [];
  var isLoaded = false;
  final dataseRef = FirebaseDatabase.instance.ref();
  _TransitPageState(this.orderno, this.outlet, this.status, this.rider);
  @override
  void initState() {
    super.initState();
    getThisOrder();
  }

  getThisOrder() async {
    final response = await http.get(Uri.parse(
        "http://api.newamadelivery.co.ke/fetchOrder.php?orderId=${orderno}"));
    setState(() {
      thisOrder = json.decode(response.body);
      isLoaded = true;
    });
  }

  Future<void> cancelThisOrder() async {
    try {
      final result1 = await http.post(
          Uri.parse("http://api.newamadelivery.co.ke/cancelOrder.php"),
          body: {"orderId": orderno, "status": "Cancelled"});
      var response2 = jsonDecode(result1.body);
      if (response2["success"] == "true") {
        print("Order has been cancelled");
      } else {
        print("Some issue occured");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Query dbRef1 = FirebaseDatabase.instance
        .ref()
        .child('Orders/${orderno}/customerDetails');
    Query dbRef2 =
        FirebaseDatabase.instance.ref().child('Orders/${orderno}/items');
    Query dbRef3 = FirebaseDatabase.instance.ref().child('Orders/${orderno}');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 63, 114),
          title: Text('Order No $orderno'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Image.asset('assets/images/cart.png'),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(197, 245, 16, 0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 260,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: Column(
                        children: [
                          Visibility(
                            visible: isLoaded,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: thisOrder?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Status - ${status}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text('|'),
                                          Text(
                                            'Store - ${outlet}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Customer: ${thisOrder![index]['customer']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Contacts: ${thisOrder![index]['contact']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Area: ${thisOrder![index]['area']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                'Landmark: ${thisOrder![index]['landmark']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Items: ${thisOrder![index]['item']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Value: Kes ${thisOrder![index]['price']}/=',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Assigned To: ${thisOrder![index]['rider']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            replacement: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      cancelThisOrder();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Order Cancelled'),
                              content:
                                  Text('Order ${orderno} has been Cancelled!'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Dashboard()));
                                    },
                                    child: Text('Back'))
                              ],
                            );
                          });
                    },
                    child: const Text('Cancel Order'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateDispatch(String status, var dispatchTime) {
    dataseRef
        .child("Orders/${orderno}")
        .update({"status": status, "CancelledTime": dispatchTime});
  }

  void updateAssignment(String status) {
    dataseRef.child("Assignments/${orderno}").update({"status": status});
  }
}
