import 'package:flutter/material.dart';
import 'package:newama2/auth/login.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
                          transform: Matrix4.translationValues(0, -60, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: Text(
                                  'Store Panel',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {},
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
