import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:newama2/general/dispatch.dart';
import 'package:newama2/general/order.dart';

class TransitPage extends StatefulWidget {
  String orderno;
  String outlet;
  String status;
  String rider;
  TransitPage({super.key, required this.orderno , required this.outlet, required this.status, required this.rider});

  @override
  State<TransitPage> createState() => _TransitPageState(orderno, outlet, status, rider);
}

class _TransitPageState extends State<TransitPage> {
  String orderno;
  String outlet;
  String status;
  String rider;
  final dataseRef = FirebaseDatabase.instance.ref();
  _TransitPageState(this.orderno, this.outlet, this.status, this.rider);

  @override
  Widget build(BuildContext context) {
    Query dbRef1 = FirebaseDatabase.instance
        .ref()
        .child('Orders/${orderno}/customerDetails');
    Query dbRef2 =
        FirebaseDatabase.instance.ref().child('Orders/${orderno}/items');
    Query dbRef3 =
        FirebaseDatabase.instance.ref().child('Orders/${orderno}');
    
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
                          Expanded(
                            child: FirebaseAnimatedList(query: dbRef1, 
                            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation,
                            int index){
                              Map orders = snapshot.value as Map;
                              orders['key'] = snapshot.key;
                              return Column(
                                
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Status - ${status}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),
                                      Text('|'),
                                      Text('Store - ${outlet}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),    

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Customer: ${orders['Customer']}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),
                                      Text('Contacts: ${orders['Contacts']}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Area: ${orders['Area']}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),
                                      Text('Landmark: ${orders['Landmark']}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),

                                    ],
                                  ),
                                     
                                ],
                              );
                              
                            }),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Text('Order Details', style: TextStyle(color: Colors.white,fontSize: 19, fontWeight: FontWeight.w500),),

                          Expanded(
                            child: FirebaseAnimatedList(query: dbRef2, 
                            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation,
                            int index){
                              Map order = snapshot.value as Map;
                              order['key'] = snapshot.key;
                              return Column(
                                
                                children: [
                                 
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Order Description: ${order['Item']}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),
                                      Text('Amount: Ksh.${order['Price']}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Quantity: ${order['Quantity']}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),
                                     
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),Text('Rider: ${rider}', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),
                                     
                                ],
                              );
                              
                            }),
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
                     updateDispatch('Cancelled',
                          DateTime.now().millisecondsSinceEpoch.toString());
                      updateAssignment('Cancelled');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Order Cancelled'),
                              content: Text(
                                  'Order ${orderno} has been Cancelled!'),
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
  
