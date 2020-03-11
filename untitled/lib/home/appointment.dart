import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/home/chatsForums.dart';
import 'package:untitled/home/findDocs.dart';
import 'package:untitled/home/profile.dart';
import 'package:untitled/home/trackMedication.dart';

class appointment extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<appointment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var divheight = MediaQuery.of(context).size.height;
    final appointments=['March 2020','March 2020','March 2020','Feb 2020','May 2020'];
    final appointment_dates=['16','17','22','31','22'];
    final appointment_days=['Saturday','Monday','Friday','Wednesday','Thursday'];
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
            height: divheight/2*0.35,
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
            children: <Widget>[
              new Container(
                height: 40,
                child: new Text("Michael Scott",
                  style: TextStyle(
                      fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black,backgroundColor: Colors.white
                  ),),
              ),
            ],
          ),
          new Container(
            height: 30,
            child: new Text("My Appointments",
              style: TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.normal,color: Colors.black,backgroundColor: Colors.white
              ),),
          ),
          Container(child: Divider(color: Color.fromRGBO(181, 166, 166, 1),),
            padding:EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0) ,),
          new Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 0.0),
            height: 25,
            child: new Text("Upcoming",textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0,fontWeight: FontWeight.normal,color: Colors.black,backgroundColor: Colors.white
              ),),
          ),
          Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(appointments[index],style: TextStyle(
                      color: Color(0xFFB5A6A6),
                    ),),
                    subtitle: Text(appointment_days[index],style:TextStyle(
                      color: Color(0xFFB5A6A6),
                    ),),
                    leading: Text(appointment_dates[index],
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),),
                    trailing: RaisedButton(
                      color: Color(0xFFC81010),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      onPressed: (){},
                      child: Text("More Details",
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),

                  ),
                );
              },
                ),
          ),
          SizedBox(height: 20.0,),
          new Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 0.0),
            height: 25,
            child: new Text("Recent",textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15.0,fontWeight: FontWeight.normal,color: Colors.black,backgroundColor: Colors.white
              ),),
          ),
          Container(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(appointments[index],style: TextStyle(
                      color: Color(0xFFB5A6A6),
                    ),),
                    subtitle: Text(appointment_days[index],style:TextStyle(
                      color: Color(0xFFB5A6A6),
                    ),),
                    leading: Text(appointment_dates[index],
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),),
                    trailing: RaisedButton(
                      color: Color(0xFFC81010),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      onPressed: (){},
                      child: Text("More Details",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ),

                  ),
                );
              },
            ),
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