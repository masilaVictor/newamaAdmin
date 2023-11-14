import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderPage extends StatefulWidget {
  String orderno;
  String outlet;
  String status;
  OrderPage(
      {super.key,
      required this.orderno,
      required this.outlet,
      required this.status});

  @override
  State<OrderPage> createState() => _OrderPageState(orderno, outlet, status);
}

class _OrderPageState extends State<OrderPage> {
  String orderno;
  String outlet;
  String status;
  List<dynamic> riders = [];
  List thisOrder = [];
  var isLoaded = false;
  String? selectedRider;

  List Riders = [];

  String? riderId;
  _OrderPageState(this.orderno, this.outlet, this.status);
  final dataseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    getThisOrder();
    getRider();

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

  getRider() async {
    final response4 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/fetchRiders.php"));
    Riders = json.decode(response4.body);

    setState(() {});
  }

  getThisOrder() async {
    final response = await http.get(Uri.parse(
        "http://api.newamadelivery.co.ke/fetchOrder.php?orderId=${orderno}"));
    setState(() {
      thisOrder = json.decode(response.body);
      isLoaded = true;
    });
  }

  Future<void> updateThisOrder() async {
    try {
      final result1 = await http.post(
          Uri.parse("http://api.newamadelivery.co.ke/updateOrder.php"),
          body: {
            "orderId": orderno,
            "assignTime": DateTime.now().millisecondsSinceEpoch.toString(),
            "rider": selectedRider as String,
            "status": "Processing"
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
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: DropdownButton(
                            value: selectedRider,
                            hint: Text('Assign Rider*'),
                            items: Riders.map((e) {
                              return DropdownMenuItem(
                                child: SizedBox(
                                    width: 200,
                                    child: Text(
                                        '${e["ridername"]} - ${e["phone"]} ')),
                                value: e["rideremail"],
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedRider = value as String;
                              });
                            }),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          backgroundColor: Color.fromARGB(255, 1, 43, 85)),
                      onPressed: () {
                        if (selectedRider == null || riderId == '') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content:
                                      Text('Please Select A Rider to Assign'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close'))
                                  ],
                                );
                              });
                        } else {
                          updateThisOrder();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Assignment Successful'),
                                  content: Text(
                                      'Notification sent to ${selectedRider}'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Dashboard()));
                                        },
                                        child: const Text('Close'))
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text('Assign Rider'))
                ],
              ),
              Image.asset('assets/images/cart.png'),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 35, 40, 44),
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(20),
                  //     topRight: Radius.circular(20)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 375.2,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Column(
                      children: [
                        Visibility(
                            visible: isLoaded,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: thisOrder?.length,
                              itemBuilder: (context, index) {
                                var dt3 =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(thisOrder![index]
                                                ['postTime']));
                                    var TAS3 =
                                        DateFormat('dd/MM/yyyy').format(dt3);
                                return Container(
                                  
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    children: [
                                      Text('Date: ${TAS3}',style: TextStyle(color: Colors.white),),
                                      const SizedBox(height: 20,),
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
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Customer: ${thisOrder![index]['customer']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                'Contacts: ${thisOrder![index]['contact']}',
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
                                        height: 10,
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
                                                height: 10,
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
                                        height: 10,
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
                                      )
                                    ],
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeOrderStatus(String status, var assTime) {
    dataseRef
        .child("Orders/${orderno}")
        .update({"status": status, "AssignedTime": assTime});
  }

  void addRiderMail(String riderEmail, orderNo, status, assignedTime, outlet) {
    dataseRef.child("Assignments").child("${orderno}").update({
      "RiderMail": riderEmail,
      "OrderNumber": orderNo,
      "status": status,
      'Time': assignedTime,
      'outlet': outlet
    });
    dataseRef
        .child("Orders")
        .child("${orderno}")
        .update({"RiderMail": riderEmail});
  }

  void assignRider(
      String orderNumber, String rider, String status, String outlet) {
    dataseRef.child("Assignments").child("${orderno}").push().set({
      "OrderNumber": orderNumber,
      "Rider": rider,
      "status": status,
      "outlet": outlet
    }).then((value) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Assignment Successful'),
              content: Text('Notification sent to ${riderId}'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      addRiderMail(
                          riderId as String,
                          orderno,
                          "Pending",
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          outlet);
                      changeOrderStatus('Processing',
                          DateTime.now().millisecondsSinceEpoch.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    },
                    child: const Text('Close'))
              ],
            );
          });
    }).onError((error, stackTrace) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Something Went Wrong'),
              content: Text('Confirm the order details are correct'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'))
              ],
            );
          });
    });
  }
}
