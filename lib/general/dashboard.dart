import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newama2/auth/test.dart';
import 'package:newama2/general/allOrders.dart';
import 'package:newama2/general/cancelled.dart';
import 'package:newama2/general/delivered.dart';
import 'package:newama2/general/dispatch.dart';
import 'package:newama2/general/dispatchOrders.dart';
import 'package:newama2/general/neworders.dart';
import 'package:newama2/general/order.dart';
import 'package:newama2/general/ordersCancelled.dart';
import 'package:newama2/general/ordersDate.dart';
import 'package:newama2/general/ordersDelivered.dart';
import 'package:newama2/general/ordersDispatch.dart';
import 'package:newama2/general/ordersPending.dart';
import 'package:newama2/general/ordersTransit.dart';
import 'package:newama2/general/returned.dart';
import 'package:newama2/general/transit.dart';
import 'package:newama2/general/transitOrders.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');

  List pendingOrders = [];
  var isLoaded = false;

  List processingOrders = [];
  var isLoaded2 = false;

  List transitOrders = [];
  var isLoaded3 = false;

  List ordersAll = [];
  List allDelivered = [];
  List allCancelled = [];
  String? selectedRider;

  List Riders = [];

  @override
  void initState() {
    super.initState();
    getPendingOrders();
    getProcessingOrders();
    getTransitOrders();
    getAllOrders();
    getallDeliveredOrders();
    getallCancelledOrders();
    getRider();
  }

  getRider() async {
    final response4 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/fetchRiders.php"));
    Riders = json.decode(response4.body);

    setState(() {});
  }

  getPendingOrders() async {
    final response1 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/pendingOrders.php"));
    setState(() {
      pendingOrders = json.decode(response1.body);
      isLoaded = true;
    });
    return pendingOrders;
  }

  getallDeliveredOrders() async {
    final response1 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/allDelivered.php"));
    setState(() {
      allDelivered = json.decode(response1.body);
    });
    return allDelivered;
  }

  getallCancelledOrders() async {
    final response1 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/allCancelled.php"));
    setState(() {
      allCancelled = json.decode(response1.body);
    });
    return allCancelled;
  }

  getAllOrders() async {
    final response1 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/allOrders.php"));
    setState(() {
      ordersAll = json.decode(response1.body);
    });
    return ordersAll;
  }

  getProcessingOrders() async {
    final response1 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/processingOrders.php"));
    setState(() {
      processingOrders = json.decode(response1.body);
      isLoaded2 = true;
    });
    return processingOrders;
  }

  getTransitOrders() async {
    final response1 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/transitOrders.php"));
    setState(() {
      transitOrders = json.decode(response1.body);
      isLoaded3 = true;
    });
    return transitOrders;
  }

  @override
  Widget build(BuildContext context) {
    int ords = ordersAll.length;
    var ordsLen = ords.toString();

    int del = allDelivered.length;
    var delLen = del.toString();

    int canc = allCancelled.length;
    var canLen = canc.toString();

    var dt4 = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    var TAS4 = DateFormat('dd/MM/yyyy').format(dt4);
    var TAS5 = TAS4;
    int check = 0;
    var dt2 = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    var TAS2 = DateFormat('dd/MM/yyyy').format(dt2);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: SizedBox(
                width: double.infinity,
                height: 262,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Welcome, Admin',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 0, 0),
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Test()));
                            },
                            child: Icon(Icons.logout_rounded))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 0, 109, 49)),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NewOrders()));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.store, color: Colors.white),
                                  Text(
                                    'All Orders',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Total: ${ordsLen}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 11, 0, 163)),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: GestureDetector(
                              onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersDelivered()));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.motorcycle_outlined,
                                      color: Colors.white),
                                  Text(
                                    'Delivered Orders',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Total: ${delLen}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 156, 146, 0)),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Icon(Icons.arrow_back_sharp,
                                      color: Colors.white),
                                  Text(
                                    'Returned Orders',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Total: 0',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 255, 0, 0)),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersCancelled()));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.backspace_sharp,
                                      color: Colors.white),
                                  Text(
                                    'Cancelled Orders',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Total: ${canLen}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: [
                  Text(
                    'Activity Summary',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'New Orders',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(50, 64, 195, 255),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order No.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text('Store',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  Text('Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  Text('Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: isLoaded,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: pendingOrders?.length,
                                  itemBuilder: (context, index) {
                                    var dt3 =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(pendingOrders![index]
                                                ['postTime']));
                                    var TAS3 =
                                        DateFormat('dd/MM/yyyy').format(dt3);
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderPage(
                                                          orderno:
                                                              pendingOrders![
                                                                      index]
                                                                  ['orderID'],
                                                          outlet:
                                                              pendingOrders![
                                                                      index]
                                                                  ['outlet'],
                                                          status:
                                                              pendingOrders![
                                                                      index]
                                                                  ['status'])));
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${pendingOrders![index]['orderID']}'),
                                                Text(
                                                    '${pendingOrders![index]['outlet']}'),
                                                Text(
                                                    '${pendingOrders![index]['status']}'),
                                                Text(TAS3)
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ));
                                  },
                                ),
                                replacement: CircularProgressIndicator(),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrdersPending()));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'View All',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Orders in Dispatch',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(49, 64, 255, 245),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order No.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text('Store',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  Text('Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  Text('Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: isLoaded2,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: processingOrders?.length,
                                  itemBuilder: (context, index) {
                                    var dt4 =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(processingOrders![index]
                                                ['postTime']));
                                    var TAS4 =
                                        DateFormat('dd/MM/yyyy').format(dt4);
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DispatchPage(
                                                          orderno:
                                                              processingOrders![
                                                                      index]
                                                                  ['orderID'],
                                                          outlet:
                                                              processingOrders![
                                                                      index]
                                                                  ['outlet'],
                                                          status:
                                                              processingOrders![
                                                                      index]
                                                                  ['status'],
                                                          rider:
                                                              processingOrders![
                                                                      index]
                                                                  ['rider'])));
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${processingOrders![index]['orderID']}'),
                                                Text(
                                                    '${processingOrders![index]['outlet']}'),
                                                Text(
                                                    '${processingOrders![index]['status']}'),
                                                Text(TAS4)
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ));
                                  },
                                ),
                                replacement: CircularProgressIndicator(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrdersDispatch()));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'View All',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Orders on Transit',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(48, 64, 115, 255),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order No.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text('Store',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  Text('Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  Text('Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: isLoaded3,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: transitOrders?.length,
                                  itemBuilder: (context, index) {
                                    var dt5 =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(transitOrders![index]
                                                ['postTime']));
                                    var TAS5 =
                                        DateFormat('dd/MM/yyyy').format(dt5);
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransitPage(
                                                          orderno:
                                                              transitOrders![
                                                                      index]
                                                                  ['orderID'],
                                                          outlet:
                                                              transitOrders![
                                                                      index]
                                                                  ['outlet'],
                                                          status:
                                                              transitOrders![
                                                                      index]
                                                                  ['status'],
                                                          rider: transitOrders![
                                                                  index]
                                                              ['rider'])));
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${transitOrders![index]['orderID']}'),
                                                Text(
                                                    '${transitOrders![index]['outlet']}'),
                                                Text(
                                                    '${transitOrders![index]['status']}'),
                                                Text(TAS5)
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ));
                                  },
                                ),
                                replacement: CircularProgressIndicator(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrdersTransit()));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'View All',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )

                        //Orders in Transit
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
