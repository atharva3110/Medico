import 'package:flutter/material.dart';
import 'package:untitled/home/appointment.dart';
import 'package:untitled/home/chatsForums.dart';
import 'package:untitled/home/findDocs.dart';
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
    var divheight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 28),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('assets/login/header.jpg'),
                    fit: BoxFit.cover)
            ),
            height: divheight/2*0.4,
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
                  new Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          image: AssetImage('assets/login/profile.png'),
                          fit: BoxFit.scaleDown),
                    ),
                  ),
                ]
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 30,
                child: new Text("Michael Scott",
                  style: TextStyle(
                      fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black,backgroundColor: Colors.white
                  ),),
              ),
              new Icon(Icons.edit)
            ],
          ),
          Expanded(
            child: new Container(
              color: Colors.white,
              height: 200.0,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints.expand(height: 50),
                      child: TabBar(unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepPurple,
                          ),
                          tabs: [
                            Tab(child: Text('Personal',style: TextStyle(fontSize: 15.0),)),
                            Tab(child: Text('Medical',style: TextStyle(fontSize: 15.0),)),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Container(
                          color: Colors.black12,
                        ),
                        Container(
                          color: Colors.black38,
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          )

        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: [
            new UserAccountsDrawerHeader(

              accountName: new Text(widget.user.email,
                style: TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.bold,color: Color.fromRGBO(0, 0, 0, 1)
                ),
              ),
              accountEmail: new Text("Complete your profile",
                style: TextStyle(
                  fontSize: 13.0,fontWeight: FontWeight.normal,color: Color.fromRGBO(125,118,118, 1)
                ),
              ),
              currentAccountPicture: new GestureDetector(
                onTap: () => print("This is the current user"),
                child: new CircleAvatar(
                  backgroundImage: new AssetImage('assets/login/profile.jpg'),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage('assets/login/drawer_header.jpg'),fit: BoxFit.fitWidth)
              ),

            ),
            ListTile(
              leading: Icon(Icons.calendar_today,color: Color.fromRGBO(61, 13, 68, 1),),
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
              leading: Icon(Icons.people,color: Color.fromRGBO(61, 13, 68, 1),),
              title: Text("Find Doctors",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(181, 166, 166, 1),
                  //fontFamily: 'Segoe UI',
                ),),
              onTap: (){
                Navigator.of(context).pop;
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new findDocs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person,color: Color.fromRGBO(61, 13, 68, 1),),
              title: Text("My Profile",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(181, 166, 166, 1),
                  //fontFamily: 'Segoe UI',
                ),
              ),
              onTap: (){
                Navigator.of(context).pop;
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new profile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.chat,color: Color.fromRGBO(61, 13, 68, 1),),
              title: Text("Forums and Chat",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(181, 166, 166, 1),
                  //fontFamily: 'Segoe UI',
                ),
              ),
              onTap: (){
                Navigator.of(context).pop;
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new chatsForums()));
              },
            ),
            ListTile(
              leading: Icon(Icons.alarm,color: Color.fromRGBO(61, 13, 68, 1),),
              title: Text("Track Medications",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(181, 166, 166, 1),
                  //fontFamily: 'Segoe UI',
                ),
              ),
              onTap: (){
                Navigator.of(context).pop;
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new trackMedication()));
              },
            ),
            ListTile(
              leading: Icon(Icons.reply,color: Color.fromRGBO(61, 13, 68, 1),),
              title: Text("Logout",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(181, 166, 166, 1),
                  //fontFamily: 'Segoe UI',
                ),
              ),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop;
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage()));
              },
            )
          ],
        ),
        ),

    );
  }
}
