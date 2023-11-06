import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/dispatch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DispatchOrders extends StatefulWidget {
  const DispatchOrders({super.key});

  @override
  State<DispatchOrders> createState() => _DispatchOrdersState();
}

class _DispatchOrdersState extends State<DispatchOrders> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  List processingOrders = [];
  var isLoaded2 = false;

  @override
  void initState() {
    super.initState();

    getProcessingOrders();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders Ready for Dispatch'),
          backgroundColor: Color.fromARGB(255, 35, 40, 44),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: SizedBox(
              height: 500,
              child: Column(
                children: [
                  Visibility(
                    visible: isLoaded2,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: processingOrders?.length,
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
                                            builder: (context) => DispatchPage(
                                                orderno:
                                                    processingOrders![index]
                                                        ['orderID'],
                                                outlet: processingOrders![index]
                                                    ['outlet'],
                                                status: processingOrders![index]
                                                    ['status'],
                                                rider: processingOrders![index]
                                                    ['rider'])));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order No. ${processingOrders![index]['orderID']}',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                          'outlet:${processingOrders![index]['outlet']}',
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
                  //     query: dbRef.orderByChild('status').equalTo('Processing'),
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
                  //                         builder: (context) => DispatchPage(
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
