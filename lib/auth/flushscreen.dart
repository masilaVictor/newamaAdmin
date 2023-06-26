import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newama2/auth/test.dart';

class Flushscreen extends StatefulWidget {
  const Flushscreen({super.key});

  @override
  State<Flushscreen> createState() => _FlushscreenState();
}

class _FlushscreenState extends State<Flushscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Test()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/rider.png',
              width: 500,
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -100.0, 0.0),
              child: const Text(
                'NEWAMA DELIVERY',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SpinKitCubeGrid(
              color: Colors.red,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
