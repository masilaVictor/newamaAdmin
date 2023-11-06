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

  @override
  void initState() {
    super.initState();
    getPendingOrders();
    getProcessingOrders();
    getTransitOrders();
    getAllOrders();
    getallDeliveredOrders();
    getallCancelledOrders();
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
    final response1 =
        await http.get(Uri.parse("http://api.newamadelivery.co.ke/allOrders.php"));
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
                      Color.fromARGB(255, 50, 50, 50),
                      Color.fromARGB(255, 151, 151, 151),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: SizedBox(
                width: double.infinity,
                height: 242,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
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
                              primary: Color.fromARGB(255, 95, 9, 9),
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Test()));
                            },
                            child: Text('Exit'))
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
                              color: Color.fromARGB(169, 183, 253, 214)),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: GestureDetector(
                              onTap: () {},
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
                              color: Color.fromARGB(199, 96, 85, 247)),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: GestureDetector(
                              onTap: () {},
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
                              color: Color.fromARGB(169, 250, 231, 57)),
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
                              color: Color.fromARGB(197, 253, 57, 57)),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: GestureDetector(
                              onTap: () {},
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
                          child: SizedBox(
                            width: double.infinity,
                            height: 190,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order No.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text('Store',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text('Status',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Visibility(
                                    visible: isLoaded,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: pendingOrders?.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => OrderPage(
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
                                                        '${pendingOrders![index]['status']}')
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ));
                                      },
                                    ),
                                    replacement: CircularProgressIndicator(),
                                  ),
                                ),
                                // Expanded(
                                //   child: FirebaseAnimatedList(
                                //       query: dbRef
                                //           .orderByChild('status')
                                //           .equalTo('Pending'),
                                //       itemBuilder: (BuildContext context,
                                //           DataSnapshot snapshot,
                                //           Animation<double> animation,
                                //           int index) {
                                //         Map orders = snapshot.value as Map;
                                //         orders['key'] = snapshot.key;

                                //         // var dt3 = DateTime.fromMillisecondsSinceEpoch(
                                //         // orders['postTime'].millisecondsSinceEpoch);
                                //         // var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);

                                //         var dt3 =
                                //             DateTime.fromMillisecondsSinceEpoch(
                                //                 int.parse(orders['postTime']));
                                //         var TAS3 = DateFormat('dd/MM/yyyy')
                                //             .format(dt3);
                                //         check = check + 1;
                                //         if (TAS3.compareTo(TAS2) == 0) {
                                //           return GestureDetector(
                                //             onTap: () {
                                //               Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                       builder: (context) =>
                                //                           OrderPage(
                                //                               orderno:
                                //                                   snapshot.key
                                //                                       as String,
                                //                               outlet: orders[
                                //                                   'outlet'],
                                //                               status: orders[
                                //                                   'status'])));
                                //             },
                                //             child: Column(
                                //               children: [
                                //                 Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceBetween,
                                //                   children: [
                                //                     Text('${snapshot.key}'),
                                //                     Text('${orders['outlet']}'),
                                //                     Text('${orders['status']}'),
                                //                     Text('$TAS3'),
                                //                   ],
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 13,
                                //                 )
                                //               ],
                                //             ),
                                //           );
                                //         } else {
                                //           return Container();
                                //         }
                                //       }),
                                // ),
                                GestureDetector(
                                  onTap: () {},
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewOrders()));
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
                          child: SizedBox(
                            width: double.infinity,
                            height: 190,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order No.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text('Store',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text('Status',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Visibility(
                                    visible: isLoaded2,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: processingOrders?.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => DispatchPage(
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
                                                        '${processingOrders![index]['status']}')
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ));
                                      },
                                    ),
                                    replacement: CircularProgressIndicator(),
                                  ),
                                ),

                                // Expanded(
                                //   child: FirebaseAnimatedList(
                                //       query: dbRef
                                //           .orderByChild('status')
                                //           .equalTo('Processing'),
                                //       itemBuilder: (BuildContext context,
                                //           DataSnapshot snapshot,
                                //           Animation<double> animation,
                                //           int index) {
                                //         Map orders = snapshot.value as Map;
                                //         orders['key'] = snapshot.key;

                                //         // var dt3 = DateTime.fromMillisecondsSinceEpoch(
                                //         // orders['postTime'].millisecondsSinceEpoch);
                                //         // var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);

                                //         var dt3 =
                                //             DateTime.fromMillisecondsSinceEpoch(
                                //                 int.parse(orders['postTime']));
                                //         var TAS3 = DateFormat('dd/MM/yyyy')
                                //             .format(dt3);
                                //         check = check + 1;
                                //         if (TAS3.compareTo(TAS2) == 0) {
                                //           return GestureDetector(
                                //             onTap: () {
                                //               Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                       builder: (context) =>
                                //                           DispatchPage(
                                //                               orderno:
                                //                                   snapshot.key
                                //                                       as String,
                                //                               outlet: orders[
                                //                                   'outlet'],
                                //                               status: orders[
                                //                                   'status'],
                                //                               rider: orders[
                                //                                   'RiderMail'])));
                                //             },
                                //             child: Column(
                                //               children: [
                                //                 Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceBetween,
                                //                   children: [
                                //                     Text('${snapshot.key}'),
                                //                     Text('${orders['outlet']}'),
                                //                     Text('${orders['status']}'),
                                //                     Text('$TAS3'),
                                //                   ],
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 13,
                                //                 )
                                //               ],
                                //             ),
                                //           );
                                //         } else {
                                //           return Container();
                                //         }
                                //       }),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DispatchOrders()));
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
                          child: SizedBox(
                            width: double.infinity,
                            height: 190,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order No.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text('Store',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text('Status',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Visibility(
                                    visible: isLoaded3,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: transitOrders?.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => TransitPage(
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
                                                        '${transitOrders![index]['status']}')
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ));
                                      },
                                    ),
                                    replacement: CircularProgressIndicator(),
                                  ),
                                ),

                                // Expanded(
                                //   child: FirebaseAnimatedList(
                                //       query: dbRef
                                //           .orderByChild('status')
                                //           .equalTo('Transit'),
                                //       itemBuilder: (BuildContext context,
                                //           DataSnapshot snapshot,
                                //           Animation<double> animation,
                                //           int index) {
                                //         Map orders = snapshot.value as Map;
                                //         orders['key'] = snapshot.key;

                                //         // var dt3 = DateTime.fromMillisecondsSinceEpoch(
                                //         // orders['postTime'].millisecondsSinceEpoch);
                                //         // var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);

                                //         var dt3 =
                                //             DateTime.fromMillisecondsSinceEpoch(
                                //                 int.parse(orders['postTime']));
                                //         var TAS3 = DateFormat('dd/MM/yyyy')
                                //             .format(dt3);
                                //         check = check + 1;
                                //         if (TAS3.compareTo(TAS2) == 0) {
                                //           return GestureDetector(
                                //             onTap: () {
                                //               Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                       builder: (context) =>
                                //                           TransitPage(
                                //                               orderno:
                                //                                   snapshot.key
                                //                                       as String,
                                //                               outlet: orders[
                                //                                   'outlet'],
                                //                               status: orders[
                                //                                   'status'],
                                //                               rider: orders[
                                //                                   'RiderMail'])));
                                //             },
                                //             child: Column(
                                //               children: [
                                //                 Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceBetween,
                                //                   children: [
                                //                     Text('${snapshot.key}'),
                                //                     Text('${orders['outlet']}'),
                                //                     Text('${orders['status']}'),
                                //                     Text('$TAS3'),
                                //                   ],
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 13,
                                //                 )
                                //               ],
                                //             ),
                                //           );
                                //         } else {
                                //           return Container();
                                //         }
                                //       }),
                                // ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TransitOrders()));
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
