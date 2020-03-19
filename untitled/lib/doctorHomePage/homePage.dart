import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/doctorHomePage/docChatPAge.dart';
import 'package:untitled/home/chatsForums.dart';

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
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.calendar_today,
                color: Color.fromRGBO(61, 13, 68, 1),),
              title: Text("Chats",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(181, 166, 166, 1),
                  //fontFamily: 'Segoe UI',
                ),
              ),
              onTap: () {
                Navigator.of(context).pop;
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new chat_page(user: widget.user,)));
              },
            ),
          ],


        ),
      ),
      body: Container(
        child: Text(widget.user.uid),
      ),
    );
  }
}
