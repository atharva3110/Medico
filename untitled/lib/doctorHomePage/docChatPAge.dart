import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class chat_page extends StatefulWidget {
  final FirebaseUser user;

  const chat_page({Key key, this.user}) : super(key: key);
  @override
  _chat_pageState createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Chats').where('docId',isEqualTo: widget.user.uid).snapshots(),//current user id
        builder: (context,snapshot){
          if(!snapshot.hasData)
            {
              return CircularProgressIndicator();
            }
          else
            {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index)
                {
                  DocumentSnapshot docSnap=snapshot.data.documents[index];
                  return ListTile(
                    leading: new CircleAvatar(  backgroundImage: new AssetImage('assets/login/profile.jpg'),),
                    title: Text(docSnap["userName"]),
                    subtitle: Text(docSnap["lastMessage"]),
                      onTap: ()=>openChat(docSnap.documentID,docSnap)

                  );
                },
              );
            }
        },
      ),
    );
  }

  openChat(documentID, data) {

    Navigator.push(context, MaterialPageRoute(builder: (context)=>chat_box(docId: documentID.toString(),ss: data)));
  }
}


class chat_box extends StatefulWidget {
  final String docId;
  final DocumentSnapshot ss;
  const chat_box({Key key, this.docId, this.ss}) : super(key: key);
  @override
  _chat_boxState createState() => _chat_boxState();
}

class _chat_boxState extends State<chat_box> {
  String _reply;
  TextEditingController messageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
                backgroundImage: new AssetImage('assets/login/profile.jpg')),
            SizedBox(width: 30,),
            Text(widget.ss['userName']),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 455,
              child: StreamBuilder(
                stream: Firestore.instance.collection('Chats').document(widget.docId).collection('userChats').orderBy('date').snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){return CircularProgressIndicator();}
                  else
                    {
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot docSnap=snapshot.data.documents[index];
                          return ListTile(
                            leading:  CircleAvatar(
                                backgroundImage: new AssetImage('assets/login/profile.jpg')),
                            title: Text(getUserName(docSnap['from'].toString())),
                            subtitle: Text(docSnap['message']),
                          );
                        },
                      );
                    }
                },
              ),
            ),
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 5),
                      width: 280,
                      child: TextField(
                        controller: messageController,
                        onChanged: (input)=>_reply=input,
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
                      onPressed: (){
                        Firestore.instance.collection('Chats').document(widget.docId).collection('userChats').add({
                          'message': _reply,
                          'from': 'doctor',
                          'date':  DateTime.now().toIso8601String().toString()
                        });
                        Firestore.instance.collection('Chats').document(widget.docId).updateData({
                          'lastMessage': _reply
                        });
                        messageController.clear();
                      },


                      splashColor: Colors.deepPurple[400],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getUserName(docSnap) {
    if(docSnap=='user')
      {
        return "User";
      }
    else{
      return 'Me';
    }

  }
}
