import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/transit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransitOrders extends StatefulWidget {
  const TransitOrders({super.key});

  @override
  State<TransitOrders> createState() => _TransitOrdersState();
}

class _TransitOrdersState extends State<TransitOrders> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');

  List transitOrders = [];
  var isLoaded3 = false;

  @override
  void initState() {
    super.initState();
    getTransitOrders();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 35, 40, 44),
          title: Text('Orders in Transit'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: SizedBox(
              height: 500,
              child: Column(
                children: [
                  Visibility(
                    visible: isLoaded3,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: transitOrders?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 35, 40, 44),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TransitPage(
                                                orderno: transitOrders![index]
                                                    ['orderID'],
                                                outlet: transitOrders![index]
                                                    ['outlet'],
                                                status: transitOrders![index]
                                                    ['status'],
                                                rider: transitOrders![index]
                                                    ['rider'])));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order No. ${transitOrders![index]['orderID']}',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                          'outlet:${transitOrders![index]['outlet']}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                    replacement: CircularProgressIndicator(),
                  ),

                  // FirebaseAnimatedList(
                  //     query: dbRef.orderByChild('status').equalTo('Transit'),
                  //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  //         Animation<double> animation, int index) {
                  //       Map order = snapshot.value as Map;
                  //       order['key'] = snapshot.key;
                  //       return Container(
                  //         margin: const EdgeInsets.all(10),
                  //         padding: EdgeInsets.all(25),
                  //         decoration: BoxDecoration(
                  //             color: Color.fromARGB(255, 35, 40, 44),
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: Row(
                  //           children: [
                  //             GestureDetector(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) => TransitPage(
                  //                             orderno: snapshot.key as String,
                  //                             outlet: order['outlet'],
                  //                             status: order['status'],
                  //                             rider: order['RiderMail'])));
                  //               },
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Order No. ${snapshot.key}',
                  //                     style: const TextStyle(
                  //                         fontSize: 18, color: Colors.white),
                  //                   ),
                  //                   Text('outlet:${order['outlet']}',
                  //                       style: const TextStyle(
                  //                           fontSize: 15, color: Colors.white))
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //     }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
