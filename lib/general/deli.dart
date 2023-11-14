import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class DeliPage extends StatefulWidget {
  String orderno;
  String outlet;
  String status;
  String rider;
  DeliPage(
      {super.key,
      required this.orderno,
      required this.outlet,
      required this.status,
      required this.rider});

  @override
  State<DeliPage> createState() =>
      _DeliPageState(orderno, outlet, status, rider);
}

class _DeliPageState extends State<DeliPage> {
  String orderno;
  String outlet;
  String status;
  String rider;
  List thisOrder = [];
  var isLoaded = false;
  _DeliPageState(this.orderno, this.outlet, this.status, this.rider);

    getThisOrder() async {
    final response = await http.get(Uri.parse(
        "http://api.newamadelivery.co.ke/fetchOrder.php?orderId=${orderno}"));
    setState(() {
      thisOrder = json.decode(response.body);
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getThisOrder();
  }

  @override
  Widget build(BuildContext context) {
    Query dbRef1 = FirebaseDatabase.instance
        .ref()
        .child('Orders/${orderno}/customerDetails');
    Query dbRef2 =
        FirebaseDatabase.instance.ref().child('Orders/${orderno}/items');
    Query dbRef3 =
        FirebaseDatabase.instance.ref().child('Assignments/${orderno}');
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
                                var dt3 =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(thisOrder![index]
                                                ['postTime']));
                                    var TAS3 =
                                        DateFormat('dd/MM/yyyy').format(dt3);
                                return Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    children: [
                                      Text('Date: ${TAS3}',style: TextStyle(color: Colors.white),),
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
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
