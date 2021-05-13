import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nodepad/extraWidgets.dart';
import 'package:nodepad/screens/login.dart';

// ignore: must_be_immutable
class Addnotes extends StatefulWidget {
  String titleup, contentup, userid;
  Addnotes({Key key, @required this.titleup, this.contentup, this.userid})
      : super(key: key);

  @override
  _AddnotesState createState() =>
      _AddnotesState(this.titleup, this.contentup, this.userid);
}

class _AddnotesState extends State<Addnotes> {
  String titleup, contentup, userid;
  _AddnotesState(this.titleup, this.contentup, this.userid);
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  String title1, content1;

  var collections = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    TextEditingController _initialValue(val) {
      return TextEditingController(text: val);
    }

    if (userid != "") {
      title = _initialValue(titleup);
      content = _initialValue(contentup);
    }

    List<String> days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      " Friday",
      "Saturday",
      "Sunday"
    ];
    DateTime dt = DateTime.now();
    String dnt = days[dt.weekday - 1] +
        " | " +
        dt.hour.toString() +
        ":" +
        dt.minute.toString();
    return Scaffold(
      backgroundColor: d,
      appBar: AppBar(
        leading: IconButton(
            iconSize: 20,
            icon: Icon(Icons.arrow_back_ios_rounded, color: t),
            onPressed: () {
              vibe();
              Navigator.of(context).pop();
            }),
        backgroundColor: b,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: b),
            child: Text(
              "save",
              style: TextStyle(color: t, fontSize: 18),
            ),
            onPressed: () {
              vibe();
              setState(() {
                title1 = title.text;
                content1 = content.text;
              });
              if (userid == "") {
                collections
                    .collection('userdata')
                    .doc(user.uid)
                    .collection('notes')
                    .add({
                  "usernotes": {
                    "title": title1,
                    "content": content1,
                    "time": dnt
                  }
                });
              } else {
                collections
                    .collection('userdata')
                    .doc(user.uid)
                    .collection('notes')
                    .doc(userid)
                    .update({
                  "usernotes": {
                    "title": title1,
                    "content": content1,
                    "time": dnt
                  }
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 21, top: 21),
              child: TextField(
                style: TextStyle(color: d9, fontSize: 23),
                controller: title,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: d9, fontSize: 24),
                    hintText: userid == "" ? 'Title' : title.text,
                    border: InputBorder.none),
                onSubmitted: (val) {
                  print(val);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                color: t,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: TextField(
                style: TextStyle(color: d9, fontSize: 18),
                controller: content,
                maxLines: 50,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: d9, fontSize: 20),
                    hintText: userid == "" ? 'content' : content.text,
                    border: InputBorder.none),
                onSubmitted: (val) {
                  print(val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
