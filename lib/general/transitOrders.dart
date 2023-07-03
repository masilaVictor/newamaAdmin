import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/transit.dart';

class TransitOrders extends StatefulWidget {
  const TransitOrders({super.key});

  @override
  State<TransitOrders> createState() => _TransitOrdersState();
}

class _TransitOrdersState extends State<TransitOrders> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 59, 107),
          title: Text('Orders in Transit'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: SizedBox(
              height: 500,
              child: FirebaseAnimatedList(
                  query: dbRef.orderByChild('status').equalTo('Transit'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map order = snapshot.value as Map;
                    order['key'] = snapshot.key;
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 68, 102),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TransitPage(orderno: snapshot.key as String,
                                                                outlet: order['outlet'], status: order['status'], rider: order['RiderMail']
                                                                )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order No. ${snapshot.key}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text('outlet:${order['outlet']}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}