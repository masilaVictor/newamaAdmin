import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newama2/general/dashboard.dart';
import 'package:newama2/general/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newama2/general/transit.dart';

class OrdersTransit extends StatefulWidget {
  const OrdersTransit({super.key,this.restorationId});
  final String? restorationId;

  @override
  State<OrdersTransit> createState() => _OrdersTransitState();
}

class _OrdersTransitState extends State<OrdersTransit> with RestorationMixin {
  String? get restorationId => widget.restorationId;
  var Thistime =((DateTime.now().millisecondsSinceEpoch) - 86400000);
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime.fromMillisecondsSinceEpoch(
        (DateTime.now().millisecondsSinceEpoch) - 86400000));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
       
      );
    },
  );
  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023),
          lastDate: DateTime(2030),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
         Thistime = _selectedDate.value.millisecondsSinceEpoch;
         getPendingOrders();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }
  List pendingOrders = [];
  var isLoaded = false;

  getPendingOrders() async {
    final response1 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/transitByDate.php?startDate=${Thistime.toString()}"));
    setState(() {
      pendingOrders = json.decode(response1.body);
      isLoaded = true;
    });
    return pendingOrders;
  }

   @override
  void initState() {
    super.initState();
    getPendingOrders();
    
    
  }
  @override
  Widget build(BuildContext context) {
    var dt2 = DateTime.fromMillisecondsSinceEpoch(
        _selectedDate.value.millisecondsSinceEpoch);
    var TAS2 = DateFormat('dd/MM/yyyy').format(dt2);

    var thisDate = _selectedDate.value.millisecondsSinceEpoch;
    return Scaffold(
      appBar: AppBar(
        title: Text(TAS2),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton(
                        onPressed: () {
                          _restorableDatePickerRouteFuture.present();
                        },
                        child: const Text('Select Day To View',style: TextStyle(color: Colors.black),),
                      ),
                      


              Visibility(
                visible: isLoaded,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pendingOrders?.length,
                  itemBuilder: (context, index) {
                    var dt3 = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(pendingOrders![index]['postTime']));
                    var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);

                   
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                        decoration: BoxDecoration(
                              color:pendingOrders![index]['status'] == 'Pending'
                                  ? Color.fromARGB(255, 255, 17, 0)
                                  : pendingOrders![index]['status'] == 'Processing'
                                      ? const Color.fromARGB(255, 0, 45, 82)
                                      : pendingOrders![index]['status'] == 'Transit'
                                          ? const Color.fromARGB(
                                              255, 102, 92, 0)
                                          : pendingOrders![index]['status'] == 'Delivered'
                                              ? Colors.green
                                              : Color.fromARGB(80, 126, 1, 42),
                              borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                           Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TransitPage(
                                                orderno: pendingOrders![index]
                                                    ['orderID'],
                                                outlet: pendingOrders![index]
                                                    ['outlet'],
                                                status: pendingOrders![index]
                                                    ['status'],
                                                rider: pendingOrders![index]
                                                    ['rider'])));
                          },
                          child: Column(
                            children: [
                              Text(
                                'Order No. - ${pendingOrders![index]['orderID']} - ${pendingOrders![index]['outlet']}',
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
                    }
                  
                ),
                replacement: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
