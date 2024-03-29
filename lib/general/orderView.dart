import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/allOrders.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:newama2/general/order.dart';

class OrdersView extends StatefulWidget {
  String orderno;
  String outlet;
  String status;
  OrdersView(
      {super.key,
      required this.orderno,
      required this.outlet,
      required this.status});

  @override
  State<OrdersView> createState() => _OrdersViewState(orderno, outlet, status);
}

class _OrdersViewState extends State<OrdersView> {
  String orderno;
  String outlet;
  String status;
  final dataseRef = FirebaseDatabase.instance.ref();
  _OrdersViewState(this.orderno, this.outlet, this.status);

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
          backgroundColor: Color.fromARGB(255, 35, 40, 44),
          title: Text('Order No $orderno'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              Image.asset('assets/images/cart.png'),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 35, 40, 44),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 388,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Column(
                      children: [
                        Expanded(
                          child: FirebaseAnimatedList(
                              query: dbRef1,
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation<double> animation,
                                  int index) {
                                Map orders = snapshot.value as Map;
                                orders['key'] = snapshot.key;
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
                                            'Customer: ${orders['Customer']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Contacts: ${orders['Contacts']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Area: ${orders['Area']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                'Landmark: ${orders['Landmark']}',
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
                                    ],
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Text(
                          'Order Details',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: FirebaseAnimatedList(
                              query: dbRef2,
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation<double> animation,
                                  int index) {
                                Map order = snapshot.value as Map;
                                order['key'] = snapshot.key;
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Order Description: ${order['Item']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Amount: Ksh.${order['Price']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Quantity: ${order['Quantity']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('WARNING'),
                                          content: Text(
                                              'Proceeding will Cancel delivery process'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  updateOrder(
                                                      'Cancelled',
                                                      DateTime.now()
                                                          .millisecondsSinceEpoch
                                                          .toString(),
                                                      '0');
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Dashboard()));
                                                },
                                                child: Text('Proceed')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Back'))
                                          ],
                                        );
                                      });
                                },
                                child: Text('Cancel')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderPage(
                                              orderno: orderno as String,
                                              outlet: outlet,
                                              status: status)));
                                },
                                child: Text('Reassign'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void updateOrder(String status, var CancelTime, String distance) {
    dataseRef.child('Orders').child('${orderno}').update(
        {'status': status, 'DeliveryTime': CancelTime, "Distance": distance});
    dataseRef.child('Assignments').child('${orderno}').update(
        {'status': status, 'DeliveryTime': CancelTime, "Distance": distance});
  }
}
