import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nodepad/extraWidgets.dart';
import 'package:nodepad/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/auth.dart';

User user = auth.currentUser;

// ignore: camel_case_types
class loginsc extends StatefulWidget {
  const loginsc({Key key}) : super(key: key);
  static bool loogin = false;

  @override
  _loginscState createState() => _loginscState();
}

// ignore: camel_case_types
class _loginscState extends State<loginsc> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  String e, p;
  bool auther = false, load = false;

  final _showToast = () => Fluttertoast.showToast(
      msg: 'login failed',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black.withOpacity(0.4));
  void initState() {
    super.initState();
    print("login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: d1,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.37,
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Simple',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        TextSpan(
                          text: 'Note ',
                          style: TextStyle(
                              fontSize: 22,
                              color: t,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Image(
                    image: AssetImage("images/books.png"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    vibe();
                    signInWithGoogle().whenComplete(() {
                      if (loginsc.loogin == true) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Switchscreen();
                        }));
                      } else
                        _showToast();
                    });
                    if (auth.currentUser != null) {
                      setState(() {
                        auther = true;
                      });
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: d8, borderRadius: BorderRadius.circular(50)),
                      height: 50,
                      width: 235,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 30,
                            child: Image(
                              image: AssetImage("images/google.png"),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Login with google",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
