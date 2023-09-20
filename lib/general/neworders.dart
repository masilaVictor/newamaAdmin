import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:newama2/general/order.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({super.key});

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  @override
  Widget build(BuildContext context) {
    var dt4 = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    var TAS4 = DateFormat('dd/MM/yyyy').format(dt4);
    var TAS5 = TAS4;
    int check = 0;
    var dt2 = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    var TAS2 = DateFormat('dd/MM/yyyy').format(dt2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Orders'),
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
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 600,
                child: FirebaseAnimatedList(
                    query: dbRef.orderByChild('status').equalTo('Pending'),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map orders = snapshot.value as Map;
                      orders['key'] = snapshot.key;

                      // var dt3 = DateTime.fromMillisecondsSinceEpoch(
                      // orders['postTime'].millisecondsSinceEpoch);
                      // var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);

                      var dt3 = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(orders['postTime']));
                      var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);

                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 35, 40, 44),
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderPage(
                                        orderno: snapshot.key as String,
                                        outlet: orders['outlet'],
                                        status: orders['status'])));
                          },
                          child: Column(
                            children: [
                              Text(
                                'Order No. - ${snapshot.key} - ${orders['outlet']}',
                                style: TextStyle(color: Colors.white),
                              ),
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
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
