import 'package:flutter/material.dart';
import 'package:newama2/general/allOrders.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class OrdersDate extends StatefulWidget {
  
  const OrdersDate({super.key,this.restorationId,});

  final String? restorationId;
  

  @override
  State<OrdersDate> createState() => _OrdersDateState();
}

class _OrdersDateState extends State<OrdersDate> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2023, 7, 25));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }
  //String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  var sDate = '';
  var endDate = '';
  String myDate = 'false';
  var dateTimeFormat = '';
  var endDateTimeFormat = '';
  var nowDate = '';
  var thenDate = '';

  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   setState(() {
  //     if (args.value is PickerDateRange) {
  //       sDate = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)}';
  //       endDate = '${DateFormat('dd/MM/yyyy').format(args.value.endDate)}';
  //       _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
  //           // ignore: lines_longer_than_80_chars
  //           ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
  //     } else if (args.value is DateTime) {
  //       _selectedDate = args.value.toString();
  //     } else if (args.value is List<DateTime>) {
  //       _dateCount = args.value.length.toString();
  //     } else {
  //       _rangeCount = args.value.length.toString();
  //     }
  //     myDate = 'true';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (myDate == 'false') {
      dateTimeFormat = DateTime.now().millisecondsSinceEpoch.toString();
      endDateTimeFormat = DateTime.now().millisecondsSinceEpoch.toString();
    } else {
      var dateTimeFormat = DateFormat('dd/MM/yyyy', 'en_US').parse('$sDate');
      var endDateTimeFormat =
          DateFormat('dd/MM/yyyy', 'en_US').parse('$endDate');
      nowDate = dateTimeFormat.millisecondsSinceEpoch.toString();
      thenDate = endDateTimeFormat.millisecondsSinceEpoch.toString();
    }
    var dt2 = DateTime.fromMillisecondsSinceEpoch(1685694000000);
    var TAS2 = DateFormat('dd/MM/yyyy').format(dt2);
    var checkDate = '';
    var isDate = '';
    if (TAS2.compareTo(sDate) == 0) {
      checkDate = 'same dates';
    } else if (TAS2.compareTo(sDate) == 1) {
      checkDate = 'The date is before';
    } else {
      checkDate = 'The date is after';
    }
// if(TAS2.isBefore(dateTimeFormat)){
//
// }
// var checkDate = '';
// if (TAS2 > thenDate) {
// checkDate = 'true';
// }
    var d1 = 1685694523471;
// if (nowDate == TA) {
// checkDate = 'True';
// } else {
// checkDate = 'false';
// }

var thisDate = _selectedDate.value.millisecondsSinceEpoch;
    return Scaffold(
        appBar: AppBar(
          title: Text('Date Picker'),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
             OutlinedButton(
                        onPressed: () {
                          _restorableDatePickerRouteFuture.present();
                        },
                        child: const Text('Date of Occurence*'),
                      ),
                      Text(
                          'Selected: ${thisDate}'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AllOrders(selectedDate: endDate, end: sDate,)));
                  },
                  child: Text('PROCEED')),

                  
                  
            ],
          ),
        )));
  }
}
