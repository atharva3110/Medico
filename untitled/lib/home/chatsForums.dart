

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/home/appointment.dart';
import 'package:untitled/home/findDocs.dart';
import 'package:untitled/home/profile.dart';
import 'package:untitled/home/trackMedication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/local_data.json';
class chatsForums extends StatefulWidget {
 final FirebaseUser user;


  const chatsForums({Key key, this.user}) : super(key: key);

  @override
  _chatsForumsState createState() => _chatsForumsState();
}

class _chatsForumsState extends State<chatsForums> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    var divheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListPage(user: widget.user,),

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

class ListPage extends StatefulWidget {
  final FirebaseUser user;

  const ListPage({Key key, this.user}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getChats() async
  {
    var firestore=Firestore.instance;

     QuerySnapshot qn=await firestore.collection("Chats").where('userId', isEqualTo: widget.user.uid).getDocuments();


    return qn.documents;
  }

  openChat(String documentID,DocumentSnapshot data)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>chatBox(dId: documentID,ss: data)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getChats(),
          builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: Text('Loading...'),
            );
          }
        else{
          return ListView.builder(
            itemCount: snapshot.data?.length?? 0,
              itemBuilder: (_, index){
              return ListTile(
                leading: new CircleAvatar(  backgroundImage: new AssetImage('assets/login/profile.jpg'),),
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                title: Text(snapshot.data[index].data['docName']),
                subtitle: Text(snapshot.data[index].data['lastMessage']),

                onTap: ()=>openChat(snapshot.data[index].documentID.toString(),snapshot.data[index])

              );

          });
        }

      }),
    );
  }


}

class chatBox extends StatefulWidget {
  final String dId;
  final DocumentSnapshot ss;

  const chatBox({Key key, this.dId, this.ss}) : super(key: key);
  @override
  _chatBoxState createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  String _messsage;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final Firestore firestore=Firestore.instance;
  Future getChats() async
  {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection("Chats")
        .document(widget.dId)
        .collection('userChats').orderBy('date')
        .getDocuments();


    return qn.documents;
  }

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      _messsage= messageController.text;
      messageController.clear();
      await firestore.collection('Chats').document(widget.dId).collection('userChats').add({
        'message': _messsage,
        'from': 'user',
        'date': DateTime.now().toIso8601String().toString(),
      });
      await firestore.collection('Chats').document(widget.dId).updateData({
        'lastMessage': _messsage,
      });
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
                backgroundImage: new AssetImage('assets/login/profile.jpg')),
            SizedBox(width: 10,),
            Text(widget.ss.data['docName'])
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 450,
              child: FutureBuilder(
                  future: getChats(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Loading...'),
                      );
                    }
                    else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                              leading: new CircleAvatar(
                                backgroundImage: new AssetImage(
                                    'assets/login/profile.jpg'),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(
                                  10, 10, 10, 0),
                              title: Text(getTitle(snapshot.data[index].data['from'])),
                              subtitle: Text(
                                  snapshot.data[index].data['message'],
                                style: TextStyle(
                                  fontSize: 40
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 5),
                  width: 280,
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (input)=>callback(),
                    decoration: InputDecoration(
                      hintText: "Enter message",
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                FloatingActionButton(
                  child: Icon(Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: callback,

                  splashColor: Colors.deepPurple[400],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }



  String getTitle(data) {
    if(data=='user')
      {
        return "Me";
      }
    else
      {
        return widget.ss.data['docName'];
      }
  }

}

