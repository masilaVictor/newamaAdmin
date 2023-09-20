import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:newama2/general/deli.dart';
import 'package:newama2/general/order.dart';
import 'package:newama2/general/orderView.dart';
import 'package:newama2/general/ordersDate.dart';

class AllOrders extends StatefulWidget {
  var selectedDate;
  var end;
  AllOrders({super.key, required this.selectedDate, required this.end});

  @override
  State<AllOrders> createState() => _AllOrdersState(selectedDate, end);
}

class _AllOrdersState extends State<AllOrders> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  var selectedDate;
  var end;

  _AllOrdersState(this.selectedDate, this.end);
  @override
  Widget build(BuildContext context) {
    List<int> allOrders = [];
    int count = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
        backgroundColor: Color.fromARGB(255, 35, 40, 44),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Date: $selectedDate',
                    style: TextStyle(fontSize: 17),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 0, 63, 114)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrdersDate()));
                      },
                      child: Text('Change Date'))
                ],
              ),
              SizedBox(
                height: 500,
                child: FirebaseAnimatedList(
                    query: dbRef,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map order = snapshot.value as Map;
                      order['key'] = snapshot.key;
                      //var getTime = order['postTime']

                      var dt3 = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(order['postTime']));
                      var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);

                      if (TAS3.compareTo(selectedDate) == 0) {
                        //allOrders.add(index);
                        count = index;

                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: order['status'] == 'Pending'
                                  ? Color.fromARGB(255, 255, 17, 0)
                                  : order['status'] == 'Processing'
                                      ? const Color.fromARGB(255, 0, 45, 82)
                                      : order['status'] == 'Transit'
                                          ? const Color.fromARGB(
                                              255, 102, 92, 0)
                                          : order['status'] == 'Delivered'
                                              ? Colors.green
                                              : Color.fromARGB(80, 126, 1, 42),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (order['status'] == 'Pending') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrderPage(
                                                orderno: snapshot.key as String,
                                                outlet: order['outlet'],
                                                status: order['status'])));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DeliPage(
                                                orderno: snapshot.key as String,
                                                outlet: order['outlet'],
                                                rider: order['RiderMail'],
                                                status: order['status'])));
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order No. ${snapshot.key}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('outlet:${order['outlet']}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                    Text('Status:${order['status']}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Date: $TAS3',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
