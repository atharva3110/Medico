import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class replies_page extends StatefulWidget {
  final String question_id;
  final DocumentSnapshot ds;
  const replies_page({Key key, this.question_id, this.ds}) : super(key: key);
  @override
  _replies_pageState createState() => _replies_pageState();
}

class _replies_pageState extends State<replies_page> {
  String _reply;
  TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Answer(s)'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 455,
              child: StreamBuilder(
               stream: Firestore.instance.collection('Forum').document(widget.question_id).collection("replies").snapshots(),
                builder: (context,snapshot){
                 if(!snapshot.hasData)
                   {
                     return CircularProgressIndicator();
                   }
                 else
                   {
                     return ListView.builder(
                       itemCount: snapshot.data.documents.length,
                       itemBuilder: (context,index){
                         DocumentSnapshot docSnap=snapshot.data.documents[index];
                         return Card(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
                           elevation: 2.0,
                           child: Column(
                             children: <Widget>[
                               Row(
                                 children: <Widget>[
                                   CircleAvatar(  backgroundImage: new AssetImage('assets/login/profile.jpg'),),
                                   SizedBox(width: 15,),
                                   Text(docSnap['userName'],
                                   style: TextStyle(
                                     fontWeight: FontWeight.bold
                                   ),
                                   ),

                                   getIcon(docSnap)             //Shows verified symbol if reply is given by doctor
                                 ],
                               ),
                               Row(
                                 children: <Widget>[
                                   Text(docSnap['reply'])
                                 ],
                               ),

                             ],
                           ),
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

                      Firestore.instance.collection("Forum").document(widget.question_id).collection('replies').add({
                        'reply': _reply,
                        'userType': 'user',
                        'userName': 'gaurang pawar'  /* add user name from local storage*/
                      });

                      Firestore.instance.collection('Forum').document(widget.question_id).updateData({
                        'replies': FieldValue.increment(1),
                      });

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

  Icon getIcon(docSnap) {
    if(docSnap['userType']=='doctor')
      {
        return Icon(Icons.verified_user,
        color: Colors.deepPurple,);
      }
    else
      {
        return Icon(Icons.verified_user,
        color: Colors.white,);
      }
  }
}
