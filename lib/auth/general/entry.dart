// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newama2/auth/test.dart';
import 'package:flutter/services.dart';
import 'maps_location_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Entries extends StatefulWidget {
  const Entries({super.key});

  @override
  State<Entries> createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  String address = "null";
  String autocompletePlace = "null";
  Prediction? initialValue;
  final TextEditingController _controller = TextEditingController();
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
  List<dynamic> stores = [];
  String? storeId;

  String? selectedStore;

  List Stores = [];

  @override
  void initState() {
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    super.initState();
    getStores();
    this
        .stores
        .add({"id": "Naivas Gateway Mall", "label": "Naivas Gateway Mall"});
    this
        .stores
        .add({"id": "Naivas Mountain Mall", "label": "Naivas Mountain Mall"});
    this.stores.add({"id": "Naivas Spur Mall", "label": "Naivas Spur Mall"});
    this.stores.add({"id": "Naivas Thindigwa", "label": "Naivas Thindigwa"});
  }

  // triggerNotification() {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //           id: 10,
  //           channelKey: 'Newama_delivery',
  //           title: 'New Order Made',
  //           body: 'You have a new order'));
  // }

  getStores() async {
    final response4 = await http
        .get(Uri.parse("http://api.newamadelivery.co.ke/fetchStores.php"));
    Stores = json.decode(response4.body);

    setState(() {});
  }

  Future<void> insertNewOrder() async {
    if (__orderId.text != "") {
      try {
        final result = await http.post(
            Uri.parse("http://api.newamadelivery.co.ke/insert.php"),
            body: {
              "orderId": __orderId.text,
              "outlet": selectedStore,
              "item": __productNameController.text,
              "price": __priceController.text,
              "customer": __customerNameController.text,
              "contacts": __customerContacts.text,
              "area": autocompletePlace,
              "landmark": __customerStreet.text,
              "postTime": DateTime.now().millisecondsSinceEpoch.toString(),
              "status": 'Pending',
            });
        var response = jsonDecode(result.body);
        if (response["success"] == "true") {
          print("Records Added");
        } else {
          print("Some issue occured");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('All Fields are required!');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user?.email == 'naivasmountainmall@gmail.com') {
      store = 'Naivas Mountain Mall';
    } else if (user?.email == 'naivasgatewaymall@gmail.com') {
      store = 'Naivas Gateway Mall';
    } else if (user?.email == 'naivasthindigwa@gmail.com') {
      store = 'Naivas Thindigwa';
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
                      Color.fromARGB(255, 0, 5, 15),
                      Color.fromARGB(255, 255, 255, 255),
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
                      'Newama Order Entry Dashboard',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: DropdownButton(
                              value: selectedStore,
                              hint: Text('Select Store*'),
                              items: Stores.map((e) {
                                return DropdownMenuItem(
                                  child: SizedBox(
                                      width: 200, child: Text('${e["store"]}')),
                                  value: e["store"],
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedStore = value as String;
                                });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          'Enter Order details below',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
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
                        width: 130,
                        child: TextField(
                          controller: __orderId,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 43, 78),
                              )),
                              labelText: 'Order ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 180,
                        child: TextField(
                          controller: __productNameController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 43, 78),
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
                        width: 130,
                        child: TextField(
                          controller: __productQuantityController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 43, 78),
                              )),
                              labelText: 'Quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 180,
                        child: TextField(
                          controller: __priceController,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 43, 78),
                              )),
                              labelText: 'Order Value',
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
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Enter Customer details below',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 350,
                              child: TextField(
                                controller: __customerNameController,
                                decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 0, 43, 78),
                                    )),
                                    labelText: 'Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 350,
                              child: TextField(
                                controller: __customerContacts,
                                decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 0, 43, 78),
                                    )),
                                    labelText: 'Phone number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 350,
                              child: TextField(
                                controller: __customerStreet,
                                decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 0, 43, 78),
                                    )),
                                    labelText: 'Building/Nearest Landmark',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Location: $autocompletePlace"),
                          ],
                        ),
                        Row(children: [
                          ElevatedButton(
                            child: const Text('Pick location'),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MapLocationPicker(
                                      apiKey:
                                          "AIzaSyBz5gDJdtUJg9GdmeN2VwNcMMrf-0K1tqQ",
                                      canPopOnNextButtonTaped: true,
                                      currentLatLng:
                                          const LatLng(29.121599, 76.396698),
                                      onNext: (GeocodingResult? result) {
                                        if (result != null) {
                                          setState(() {
                                            address =
                                                result.formattedAddress ?? "";
                                          });
                                        }
                                      },
                                      onSuggestionSelected:
                                          (PlacesDetailsResponse? result) {
                                        if (result != null) {
                                          setState(() {
                                            autocompletePlace = result
                                                    .result.formattedAddress ??
                                                "";
                                          });
                                        }
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 0, 54, 99),
                              padding: EdgeInsets.all(15)),
                          onPressed: () {
                            if (autocompletePlace == 'null') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Location Error'),
                                      content: Text('Pick location'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'))
                                      ],
                                    );
                                  });
                            } else {
                              if (__orderId.text.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Entry Error!'),
                                        content:
                                            Text('Áll Fields are required'),
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
                                // insertOrder(
                                //     __orderId.text,
                                //     __productNameController.text,
                                //     __priceController.text,
                                //     __productQuantityController.text);
                                // insertCustomerDetails(
                                //     __customerNameController.text,
                                //     __customerContacts.text,
                                //     autocompletePlace,
                                //     __customerStreet.text);
                                // triggerNotification();

                                // changeOrderStatus(
                                //     'Pending',
                                //     storeId!,
                                //     DateTime.now()
                                //         .millisecondsSinceEpoch
                                //         .toString());

                                insertNewOrder();

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Successful Entry'),
                                        content: Text(
                                            'Order ${__orderId.text} was successfully entered'),
                                        actions: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      255, 0, 48, 88)),
                                              onPressed: () {
                                                clearText();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Next Order')),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 185, 12, 0)),
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Test()));
                                              },
                                              child: Text('Exit'))
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 22),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              backgroundColor:
                                  const Color.fromARGB(255, 171, 11, 0)),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Test()));
                          },
                          child: const Text(
                            'Exit',
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

  void changeOrderStatus(String status, String outlet, var postTime) {
    dataseRef
        .child("Orders/${__orderId.text}")
        .update({"status": status, "outlet": outlet, "postTime": postTime});
  }

  void insertOrder(
    String orderId,
    String itemName,
    String itemPrice,
    String itemQuantity,
  ) {
    dataseRef.child("Orders").child("${__orderId.text}/items").push().set({
      'orderId': orderId,
      'Item': itemName,
      'Price': itemPrice,
      'Quantity': itemQuantity,
    });
  }

  void insertCustomerDetails(
    String customerName,
    String customerNumber,
    String area,
    String street,
  ) {
    dataseRef
        .child("Orders")
        .child("${__orderId.text}/customerDetails")
        .push()
        .set({
      'Customer': customerName,
      'Contacts': customerNumber,
      'Area': area,
      'Landmark': street,
    });

    dataseRef.child("Orders").child("${__orderId.text}").update({
      'Customer': customerName,
      'Contacts': customerNumber,
      'Area': area,
      'Landmark': street,
    });
  }

  void clearText() {
    __productNameController.clear();
    __orderId.clear();
    __productQuantityController.clear();
    __priceController.clear();
    __customerNameController.clear();
    __customerContacts.clear();
    __townController.clear();
    __customerStreet.clear();
  }
}
