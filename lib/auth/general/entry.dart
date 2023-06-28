import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newama2/auth/test.dart';

class Entries extends StatefulWidget {
  const Entries({super.key});

  @override
  State<Entries> createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  final TextEditingController __productNameController = TextEditingController();
  final TextEditingController __productQuantityController =
      TextEditingController();
  final TextEditingController __customerNameController =
      TextEditingController();
  final TextEditingController __customerContacts = TextEditingController();
  final TextEditingController __customerStreet = TextEditingController();
  final TextEditingController __orderId = TextEditingController();
  final TextEditingController __townController = TextEditingController();
  final TextEditingController __priceController = TextEditingController();
  final TextEditingController __outletController = TextEditingController();

  final dataseRef = FirebaseDatabase.instance.ref();
  final User? user = FirebaseAuth.instance.currentUser;
  String store = '';

  @override
  Widget build(BuildContext context) {
    if (user?.email == 'naivasmountainmall@gmail.com') {
      store = 'Naivas Mountain Mall';
    } else if (user?.email == 'naivasgatewaymall@gmail.com') {
      store = 'Naivas Gateway Malll';
    } else {
      store = 'No Store Selected';
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 119, 194, 255),
                      Color.fromARGB(255, 1, 62, 112),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'Welcome to Newama Order Entry Dashboard',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.red),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Store: $store',
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Enter Order details below',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: TextField(
                          controller: __orderId,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Order ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextField(
                          controller: __productNameController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Order Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: TextField(
                          controller: __productQuantityController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextField(
                          controller: __priceController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Order Price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Enter Customer details below',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 170,
                        child: TextField(
                          controller: __customerNameController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 170,
                        child: TextField(
                          controller: __customerContacts,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Phone number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 170,
                        child: TextField(
                          controller: __townController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Town/Area',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 170,
                        child: TextField(
                          controller: __customerStreet,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                              )),
                              labelText: 'Building/Nearest Landmark',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.all(15)),
                          onPressed: () {
                            if (__orderId.text.isEmpty &&
                                __productNameController.text.isEmpty &&
                                __productQuantityController.text.isEmpty &&
                                __priceController.text.isEmpty &&
                                __customerNameController.text.isEmpty &&
                                __customerContacts.text.isEmpty &&
                                __townController.text.isEmpty &&
                                __customerStreet.text.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Entry Error!'),
                                      content: Text('Áll Fields are required'),
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
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 22),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15)),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Test()));
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 22),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
