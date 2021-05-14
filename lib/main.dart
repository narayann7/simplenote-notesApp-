import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nodepad/extraWidgets.dart';
import 'package:nodepad/screens/login.dart';
import 'package:nodepad/screens/mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cabin',
        primarySwatch: Colors.teal,
        backgroundColor: b1,
        accentColorBrightness: Brightness.dark,
        accentColor: t3,
      ),
      home: Switchscreen(),
    );
  }
}

class Switchscreen extends StatefulWidget {
  Switchscreen({Key key}) : super(key: key);

  @override
  _SwitchscreenState createState() => _SwitchscreenState();
}

class _SwitchscreenState extends State<Switchscreen> {
  User _user1;
  @override
  void initState() {
    print("switch");
    super.initState();
    setState(() {
      _user1 = FirebaseAuth.instance.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user1 == null ? loginsc() : Homescreen();
  }
}
