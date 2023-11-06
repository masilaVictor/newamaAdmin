import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:newama2/general/order.dart';
import 'package:newama2/general/orderView.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DispatchPage extends StatefulWidget {
  String orderno;
  String outlet;
  String status;
  String rider;

  DispatchPage(
      {super.key,
      required String this.orderno,
      required this.outlet,
      required this.status,
      required this.rider});

  @override
  State<DispatchPage> createState() =>
      _DispatchPageState(orderno, outlet, status, rider);
}

class _DispatchPageState extends State<DispatchPage> {
  String orderno;
  String outlet;
  String status;
  String rider;
  String? riderId;
  List<dynamic> riders = [];
  List thisOrder = [];
  var isLoaded = false;
  _DispatchPageState(this.orderno, this.outlet, this.status, this.rider);
  final dataseRef = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();
    getThisOrder();
    this
        .riders
        .add({"id": "philipkip@gmail.com", "label": "Philip Kip(0706034707)"});
    this
        .riders
        .add({"id": "fredrick@gmail.com", "label": "Fredrick(0710322508)"});
    this.riders.add(
        {"id": "basilkidake@gmail.com", "label": "Basil Kidake(0719626745)"});
    this.riders.add(
        {"id": "wilfredkeya@gmail.com", "label": "Wilfred Keya(0745821645)"});
    this.riders.add(
        {"id": "jothamngota@gmail.com", "label": "Jotham Ngota(0723239589)"});
    this.riders.add(
        {"id": "bonfaceweru@gmail.com", "label": "Bonface Weru(0101488568)"});
    this.riders.add(
        {"id": "davidivuthah@gmail.com", "label": "David Ivuthah(0712673243)"});
    this
        .riders
        .add({"id": "johnk@gmail.com", "label": "John Kingori(0748012051)"});
    this
        .riders
        .add({"id": "abelsakwa@gmail.com", "label": "Abel Sakwa(0724386160)"});
    this.riders.add({
      "id": "anthonyrachel@gmail.com",
      "label": "Anthony Rachel(0706242354)"
    });
  }

  getThisOrder() async {
    final response = await http.get(Uri.parse(
        "http://api.newamadelivery.co.ke/fetchOrder.php?orderId=${orderno}"));
    setState(() {
      thisOrder = json.decode(response.body);
      isLoaded = true;
    });
  }

  Future<void> dispatchThisOrder() async {
    try {
      final result1 = await http.post(
          Uri.parse("http://api.newamadelivery.co.ke/dispatchOrder.php"),
          body: {
            "orderId": orderno,
            "dispatchTime": DateTime.now().millisecondsSinceEpoch.toString(),
            "status": "Transit"
          });
      var response2 = jsonDecode(result1.body);
      if (response2["success"] == "true") {
        print("Order Updated Successfully");
      } else {
        print("Some issue occured");
      }
    } catch (e) {
      print(e);
    }
  }

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
            child: Column(
              children: [
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
                    height: 385,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Visibility(
                            visible: isLoaded,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: thisOrder?.length,
                              itemBuilder: (context, index) {
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
                                            'Customer: ${thisOrder![index]['customer']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Contacts: ${thisOrder![index]['contact']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Area: ${thisOrder![index]['area']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                'Landmark: ${thisOrder![index]['landmark']}',
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
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Items: ${thisOrder![index]['item']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Value: Kes ${thisOrder![index]['price']}/=',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Assigned To: ${thisOrder![index]['rider']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            replacement: CircularProgressIndicator(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    onPressed: () {
                                      dispatchThisOrder();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Dispatch successful'),
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
                                    child: const Text('Dispatch Order')),
                                ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Confirm'),
                                              content: Text(
                                                  'Do you want to proceed to reassignment?'),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Cancel')),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.blue),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OrderPage(
                                                                      orderno:
                                                                          orderno,
                                                                      outlet:
                                                                          outlet,
                                                                      status:
                                                                          status)));
                                                    },
                                                    child: Text('Confirm'))
                                              ],
                                            );
                                          });
                                    },
                                    child: Text('Reassign'))
                              ],
                            ),
                          )
                        ],
                      ),
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
