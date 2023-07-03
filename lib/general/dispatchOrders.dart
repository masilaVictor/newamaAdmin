import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/dispatch.dart';

class DispatchOrders extends StatefulWidget {
  const DispatchOrders({super.key});

  @override
  State<DispatchOrders> createState() => _DispatchOrdersState();
}

class _DispatchOrdersState extends State<DispatchOrders> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders Ready for Dispatch'),
          backgroundColor: const Color.fromARGB(255, 0, 62, 112),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: SizedBox(
              height: 500,
              child: FirebaseAnimatedList(
                  query: dbRef.orderByChild('status').equalTo('Processing'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map order = snapshot.value as Map;
                    order['key'] = snapshot.key;
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DispatchPage(orderno: snapshot.key as String,
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
