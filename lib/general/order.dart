import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  String orderno;
  OrderPage({super.key, required this.orderno});

  @override
  State<OrderPage> createState() => _OrderPageState(orderno);
}

class _OrderPageState extends State<OrderPage> {
  String orderno;
  _OrderPageState(this.orderno);

  @override
  Widget build(BuildContext context) {
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
                    color: Color.fromARGB(197, 251, 105, 95),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
