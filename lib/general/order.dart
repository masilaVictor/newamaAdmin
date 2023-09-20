import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

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

  String? riderId;
  _OrderPageState(this.orderno, this.outlet, this.status);
  final dataseRef = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();
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
    this
        .riders
        .add({"id": "franklin@gmail.com", "label": "Franklin(0706454249)"});
    this
        .riders
        .add({"id": "johnk@gmail.com", "label": "John Kingori(0748012051)"});
    this.riders.add(
        {"id": "godfreyjuma@gmail.com", "label": "Godfrey Jume(0714239294)"});
    this.riders.add({
      "id": "wycliffochieng@gmail.com",
      "label": "Wycliff Ochieng(0724836975)"
    });
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
                    height: 300,
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
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: SizedBox(
                        width: 180,
                        child: FormHelper.dropDownWidget(
                          context,
                          "Select Rider",
                          this.riderId,
                          this.riders,
                          (onChangedVal) {
                            this.riderId = onChangedVal;
                          },
                          (onValidateVal) {
                            return null;
                          },
                          borderColor: const Color.fromARGB(255, 158, 11, 0),
                          borderFocusColor: Color.fromARGB(255, 158, 11, 0),
                          borderRadius: 10,
                          optionValue: "id",
                          optionLabel: "label",
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            backgroundColor: Color.fromARGB(255, 1, 43, 85)),
                        onPressed: () {
                          if (riderId == null || riderId == '') {
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
                          }
                          assignRider(orderno, riderId!, 'Pending', outlet);
                        },
                        child: const Text('Assign Rider'))
                  ],
                )
              ],
            ),
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
