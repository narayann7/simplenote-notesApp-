import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nodepad/extraWidgets.dart';
import 'package:nodepad/main.dart';
import 'package:nodepad/screens/login.dart';
import '../services/auth.dart';
import 'addnotes.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    if (user.uid == null) Navigator.pop(context);
    print("main");
  }

  final SnackBar snackBar = SnackBar(
    backgroundColor: d4,
    content: const Text('Note has been deleted !'),
    duration: const Duration(seconds: 2),
  );
  showAlertDeleteDialog(BuildContext context, DocumentSnapshot ds) {
    AlertDialog alert = AlertDialog(
      contentTextStyle: TextStyle(fontSize: 18, color: w),
      backgroundColor: Colors.transparent,
      content: Container(
        width: 280.0,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("this note will be deleted !"),
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: d6),
                    onPressed: () {
                      vibe();
                      collections
                          .collection("userdata")
                          .doc(user.uid)
                          .collection("notes")
                          .doc(ds.id)
                          .delete();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      "confirm",
                      style: TextStyle(fontSize: 18, color: w),
                    )),
                SizedBox(width: 32.1),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: d6),
                    onPressed: () {
                      vibe();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "no",
                      style: TextStyle(fontSize: 18, color: w),
                    )),
              ],
            )
          ],
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: d3,
          borderRadius: new BorderRadius.all(new Radius.circular(12.4)),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertLogoutDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      contentTextStyle: TextStyle(fontSize: 18, color: w),
      backgroundColor: Colors.transparent,
      content: Container(
        width: 280.0,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email),
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: d6),
                    onPressed: () {
                      vibe();
                      googleSignIn.disconnect();
                      auth.signOut();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (contex) => Switchscreen()));
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 18, color: w),
                    )),
                SizedBox(width: 32.1),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: d6),
                    onPressed: () {
                      vibe();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "no",
                      style: TextStyle(fontSize: 18, color: w),
                    )),
              ],
            )
          ],
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: d3,
          borderRadius: new BorderRadius.all(new Radius.circular(12.4)),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextEditingController k = TextEditingController();
  TextEditingController v = TextEditingController();

  String k1 = "hello", v1;
  var collections = FirebaseFirestore.instance;
  User user = auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: d,
        floatingActionButton: FloatingActionButton(
          backgroundColor: d8,
          child: Icon(
            Icons.add,
            color: t,
          ),
          onPressed: () {
            vibe();
            Navigator.push(
                context,
                ScaleRoute(
                    page: Addnotes(
                  titleup: "",
                  contentup: "",
                  userid: "",
                )));
          },
        ),
        body: NestedScrollView(
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: b,
                expandedHeight: 150,
                leading: GestureDetector(
                    onTap: () {
                      vibe();
                      showAlertLogoutDialog(context);
                    },
                    child: Icon(Icons.logout)),
                leadingWidth: 50,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image(
                    // fit: BoxFit.fitHeight,
                    alignment: Alignment.bottomRight,
                    image: AssetImage(
                      "images/right.png",
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'N',
                            style: TextStyle(color: w, fontSize: 24.5)),
                        TextSpan(
                          text: 'otes ',
                          style: TextStyle(
                              fontSize: 22,
                              color: w,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: collections
                  .collection("userdata")
                  .doc(user.uid)
                  .collection('notes')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 14.5, right: 14.5, top: 10),
                        child: GestureDetector(
                          onTap: () {
                            vibe();
                            Navigator.push(
                                context,
                                ScaleRoute(
                                    page: Addnotes(
                                  titleup: ds['usernotes']["title"],
                                  contentup: ds['usernotes']["content"],
                                  userid: ds.id,
                                )));
                          },
                          onLongPress: () {
                            vibe();
                            showAlertDeleteDialog(context, ds);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: d4,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ds['usernotes']["title"],
                                        style:
                                            TextStyle(color: d9, fontSize: 14),
                                      ),
                                      Text(
                                        ds['usernotes']["time"].toString(),
                                        style:
                                            TextStyle(color: d9, fontSize: 10),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    ds['usernotes']["content"],
                                    style: TextStyle(color: d9, fontSize: 15.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else
                  return Container(
                      alignment: Alignment.center,
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}
