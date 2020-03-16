import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/home/appointment.dart';
import 'package:untitled/home/chatsForums.dart';
import 'package:untitled/home/findDocs.dart';
import 'package:untitled/home/forum_page.dart';
import 'package:untitled/home/profile.dart';
import 'package:untitled/home/trackMedication.dart';
import 'package:untitled/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class homePage extends StatefulWidget {
  final FirebaseUser user;

  const homePage({Key key, this.user}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
   Firestore _firestoredb=Firestore.instance;
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

    Future getUserInfo() async
    {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore.collection("Users").where('email',isEqualTo: widget.user.email)
          .getDocuments();
      return qn.documents;
    }

    var divheight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 28),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('assets/login/header_home.jpg'),
                    fit: BoxFit.fill)
            ),
            height: 110,
            child: new Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          InkWell(
                            child: Icon(Icons.menu, color: Colors.white,),
                            onTap: () => _scaffoldKey.currentState.openDrawer(),
                          )
                        ],
                      ),
                    ],
                  ),
                ]
            ),
          ),
          new Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 0.0),
            height: 30,
            child: new Text("Welcome Back,",textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black,backgroundColor: Colors.white
              ),),
          ),
          new Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
            height: 30,
            child: FutureBuilder(
                future: getUserInfo(),
                builder: (_, snapshot){
                  return new Text(snapshot.data[0]['name']+'!',textAlign: TextAlign.left,
                  style: TextStyle(
                  fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black,backgroundColor: Colors.white
                  ),
                  );
                  },
            ),
          ),
          Container(child: Divider(color: Color.fromRGBO(181, 166, 166, 1),
          ),
            padding:EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0) ,),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: 18,
                child: Text('Reminder(s)',style: TextStyle(
                  fontSize: 14,color: Color((0xFFB5A6A6),
                ),
                ),
                ),
              ),
              Container(
                height: 80,
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF020061), Color(0xFF3D0D44)]
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left:20,top: 10,right: 20),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.check_circle,color: Colors.white,),
                        SizedBox(width: 10,),
                        Icon(Icons.alarm,color: Colors.white,),
                      ],
                    ),
                    leading: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 5,),
                        Text('Meprobamate',style: TextStyle(
                          fontSize: 16,color: Colors.white,
                        ),),
                        Text('Take 1',style: TextStyle(
                          fontSize: 14,color: Color(0xFFB5A6A6),
                        ),),
                        Text('12:00pm',style: TextStyle(
                          fontSize: 14,color: Color(0xFFB5A6A6),
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      drawer: new Drawer(
        child: FutureBuilder(
          future: getUserInfo(),
          builder: (_, snapshot) {
            return new ListView(
              padding: EdgeInsets.zero,
              children: [
                new UserAccountsDrawerHeader(
                  accountName: new Text(snapshot.data[0]['name'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1)
                    ),
                  ),
                  accountEmail: new Text("Complete your profile",
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(125, 118, 118, 1)
                    ),
                  ),
                  currentAccountPicture: new GestureDetector(
                    onTap: () => print("This is the current user"),
                    child: new CircleAvatar(
                      backgroundImage: new AssetImage(
                          'assets/login/profile.jpg'),
                    ),
                  ),
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage('assets/login/drawer_header.jpg'),
                          fit: BoxFit.fitWidth)
                  ),

                ),
                ListTile(
                  leading: Icon(Icons.calendar_today,
                    color: Color.fromRGBO(61, 13, 68, 1),),
                  title: Text("My Appointments",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(181, 166, 166, 1),
                      //fontFamily: 'Segoe UI',
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop;
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new appointment()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.people, color: Color.fromRGBO(61, 13, 68, 1),),
                  title: Text("Find Doctors",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(181, 166, 166, 1),
                      //fontFamily: 'Segoe UI',
                    ),),
                  onTap: () {
                    Navigator.of(context).pop;
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new findDocs()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.person, color: Color.fromRGBO(61, 13, 68, 1),),
                  title: Text("My Profile",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(181, 166, 166, 1),
                      //fontFamily: 'Segoe UI',
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop;
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new profile()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.chat, color: Color.fromRGBO(61, 13, 68, 1),),
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
                        builder: (BuildContext context) =>
                        new chatsForums(user: widget.user,)));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.forum, color: Color.fromRGBO(61, 13, 68, 1),),
                  title: Text("Forums",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(181, 166, 166, 1),
                      //fontFamily: 'Segoe UI',
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop;
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new forum_page()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.alarm, color: Color.fromRGBO(61, 13, 68, 1),),
                  title: Text("Track Medications",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(181, 166, 166, 1),
                      //fontFamily: 'Segoe UI',
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop;
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (
                            BuildContext context) => new trackMedication()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.reply, color: Color.fromRGBO(61, 13, 68, 1),),
                  title: Text("Logout",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(181, 166, 166, 1),
                      //fontFamily: 'Segoe UI',
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop;
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePage()));
                  },
                )
              ],
            );
          }
        ),
        ),
    );
  }
}
