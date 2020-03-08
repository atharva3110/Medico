import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/home/appointment.dart';
import 'package:untitled/home/findDocs.dart';
import 'package:untitled/home/profile.dart';
import 'package:untitled/home/trackMedication.dart';

class chatsForums extends StatefulWidget {
  @override
  _chatsForumsState createState() => _chatsForumsState();
}

class _chatsForumsState extends State<chatsForums> {
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
            ],
          ),
        ],
      ),

      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: [
            new UserAccountsDrawerHeader(
              accountName: new Text("Michael Scott",
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
            )
          ],
        ),
      ),

    );
  }
}