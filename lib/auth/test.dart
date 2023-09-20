import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newama2/auth/admin.dart';
import 'package:newama2/auth/general/entry.dart';
import 'package:newama2/auth/login.dart';
import 'package:newama2/general/dashboard.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            decoration: BoxDecoration(color: Color.fromARGB(255, 0, 67, 123)),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Container(
                      transform: Matrix4.translationValues(0, -60.0, 0),
                      child: Image.asset(
                        'assets/images/newama2.png',
                      ),
                    )),
                Container(
                  transform: Matrix4.translationValues(0, -150, 0.0),
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40))),
                  child: SizedBox(
                    width: double.infinity,
                    height: 600,
                    child: Column(
                      children: [
                        Image.asset('assets/images/rider.png'),
                        Container(
                          margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                          transform: Matrix4.translationValues(0, -60, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 1, 23, 42),
                                    padding: EdgeInsets.all(10)),
                                onPressed: () {
                                  FirebaseAuth.instance
                                      .authStateChanges()
                                      .listen((User? user) {
                                    if (user == null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Entries()));
                                    }
                                  });
                                },
                                child: Text(
                                  'Store Panel',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(10),
                                      backgroundColor:
                                          const Color.fromARGB(255, 134, 9, 0)),
                                  onPressed: () {
                                    FirebaseAuth.instance
                                        .authStateChanges()
                                        .listen((User? user) {
                                      if (user == null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminLogin()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Dashboard()));
                                      }
                                    });
                                  },
                                  child: Text('Admin',
                                      style: TextStyle(fontSize: 22)))
                            ],
                          ),
                        )
                      ],
                    ),
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
