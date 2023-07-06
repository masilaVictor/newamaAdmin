import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class DispatchPage extends StatefulWidget {
  String orderno;
  String outlet;
  String status;
  String rider;

  DispatchPage({super.key, required String this.orderno, required this.outlet, required this.status, required this.rider});

  @override
  State<DispatchPage> createState() => _DispatchPageState(orderno,outlet,status,rider);
}

class _DispatchPageState extends State<DispatchPage> {
  String orderno;
  String outlet;
  String status;
  String rider;
  String? riderId;
  List<dynamic> riders = [];
  _DispatchPageState(this.orderno, this.outlet, this.status, this.rider);
  final dataseRef = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();
    this.riders.add({"id": "philipkip@gmail.com", "label": "Philip Kip"});
    this.riders.add({"id": "fredrick@gmail.com", "label": "Fredrick"});
    this.riders.add({"id": "johnkamau@gmail.com", "label": "John Kamau"});
    this.riders.add({"id": "alphonce@gmail.com", "label": "Alphonce Mutuku"});
    this.riders.add({"id": "wilfredkeya@gmail.com", "label": "Wilfred Keya"});
  }

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
                     updateDispatch('Transit',
                          DateTime.now().millisecondsSinceEpoch.toString());
                      updateAssignment('Dispatched');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Dispatch successful'),
                              content: Text(
                                  'Order ${orderno} has been dispatched and is in Transit Now!'),
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
                  child: const Text('Dispatch Order'))
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
        .update({"status": status, "DispatchTime": dispatchTime});
  }

  void updateAssignment(String status) {
    dataseRef.child("Assignments/${orderno}").update({"status": status});
  }
 
  }