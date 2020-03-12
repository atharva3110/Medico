import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homePage extends StatefulWidget {
  final FirebaseUser user;

  const homePage({Key key, this.user}) : super(key: key);
  @override
  _homePageState createState() => _homePageState();
}


class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors Homepage"),
      ),
      body: Container(
        child: Text(widget.user.uid),
      ),
    );
  }
}
