import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newama2/auth/flushscreen.dart';
import 'package:newama2/auth/test.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //       channelKey: 'Newama_delivery', 
  //       channelName: 'Newama Delivery Notifications', 
  //       channelDescription: 'Notifications Channel for Newama Delivery')
  //   ],
  //   debug: true,

  // );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Flushscreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Flushscreen(),
    );
  }
}
