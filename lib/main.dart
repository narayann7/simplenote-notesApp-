import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nodepad/extraWidgets.dart';
import 'package:nodepad/screens/login.dart';

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
      home: loginsc(),
    );
  }
}

//   SplashScreen(
//   backgroundColor: d,
//   image: Image.asset("images/eyes.gif"),
//   navigateAfterSeconds:
// );
