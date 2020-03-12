  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/home/appointment.dart';
import 'package:untitled/home/chatsForums.dart';
import 'package:untitled/home/profile.dart';
import 'package:untitled/home/searchservice.dart';
import 'package:untitled/home/trackMedication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class findDocs extends StatefulWidget {
  @override
  _findDocsState createState() => _findDocsState();
}

class _findDocsState extends State<findDocs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

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
                child: new Text("Find Doctors",
                  style: TextStyle(
                      fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black,backgroundColor: Colors.white
                  ),),
              ),
            ],
          ),
          TextField(
            onChanged: (value)
            {
              initiateSearch(value);
            },
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: 'Search by name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0))),
          ),

          SizedBox(height: 395,
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),


              GridView.count(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  primary: false,
                  shrinkWrap: true,
                  children: tempSearchStore.map((element) {
                    return buildResultCard(context,element);
                  }).toList())
            ]
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
                    builder: (BuildContext context) => new trackMedication()
                )
                );
              },
            )
          ],
        ),
      ),
    );
  }

}

Widget  buildResultCard(BuildContext contex1,data)
{
  return Card(

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 2.0,
    child: Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),

            CircleAvatar(
              backgroundImage: AssetImage('assets/login/profile.jpg'),
            ),
            Text(data['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0
              ),
            ),
            Text('Avg rating:'+data['rating']),

            Text('Contact:'+data['phn']),
            RaisedButton(
              onPressed: (){
                showProfile(contex1, data);

              },
              splashColor: Colors.deepPurple[300],
              color: Colors.deepPurple,
              child: Text("See details",
              style: TextStyle(
                color: Colors.white
              ),
              ),

            )
          ],
        ),
      ),
    ),
  );
}

Future<bool> showProfile(BuildContext contex,data)
{
  return showDialog(context: contex,
    barrierDismissible: true,
    builder: (BuildContext contex)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
          height: 400.0,
          width: 300.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  SizedBox(width: 40,),

                  CircleAvatar(
                    backgroundImage: AssetImage('assets/login/profile.jpg'),
                    radius: 35,
                  ),
                  Text(data['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  )
                ],
              ),
             Row(

               children: <Widget>[
                 SizedBox(width:100,
                 ),
                 Icon(Icons.call,
                   color: Colors.deepPurple,
                 ),

                 Icon(Icons.mail,
                   color: Colors.deepPurple,
                 ),

                 Icon(Icons.directions,
                   color: Colors.deepPurple,
                 )
               ],
             ),

              Text('Details of doctor will be displayed below'),

              SizedBox(height: 150,),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){},
                    color: Colors.deepPurple,
                    child: Text("Chat",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){},
                    color: Colors.deepPurple,
                    child: Text("Book Appointment",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  );
}
