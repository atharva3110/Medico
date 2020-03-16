import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/home/chatsForums.dart';
import 'package:untitled/home/replies_page.dart';


class forum_page extends StatefulWidget {
  @override
  _forum_pageState createState() => _forum_pageState();
}

class _forum_pageState extends State<forum_page> {
  Icon actionIcon =Icon(Icons.search);
  Widget appBarTitle= Text('Forum');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: (){
            setState(() {
              if(this.actionIcon.icon==Icons.search)
                {
                  this.actionIcon= new Icon(Icons.close);
                  this.appBarTitle= new TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                    ),
                    style: new TextStyle(
                      color: Colors.white
                    ),
                  );
                }
              else{
                this.actionIcon= new Icon(Icons.search);
                this.appBarTitle= new Text('Forum');
              }
            });
          })
        ],
      ),

      body: Scaffold(
        floatingActionButton: new FloatingActionButton(onPressed: (){},
          child: Icon(Icons.add_comment),
          splashColor: Colors.deepPurple[400],
        ),
        body: Container(
          child: StreamBuilder(
            stream:  Firestore.instance.collection('Forum').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                {
                  return CircularProgressIndicator();
                }
              else
                {
                  return ListView.builder(


                    itemCount: snapshot.data.documents.length,
                    itemBuilder:(context, index){
                      DocumentSnapshot docSnap=snapshot.data.documents[index];
                      var isPressed=false;
                      String question= docSnap['question'].toString();
                      String replies= docSnap['replies'].toString();
                     return Card(

                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                       elevation: 2.0,
                       child: Column(
                         children: <Widget>[

                           Text(docSnap['question'],
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 19
                             ),
                           ),
                           Row(
                             children: <Widget>[
                               IconButton(
                                 icon: Icon(Icons.thumb_up),
                                 color: (isPressed) ? Colors.deepPurple: Colors.blueGrey,
                                 onPressed: (){
                                   setState(() {
                                     if(isPressed==false)
                                     {
                                       isPressed=true;
                                     }
                                     else
                                     {
                                       isPressed=false;
                                     }
                                   }
                                   );
                                 },
                               ),
                               SizedBox(width: 15,),
                               Text(replies),               //number of replies(show toast in replies in 0)
                               IconButton(
                                 icon: Icon(Icons.comment),
                                 onPressed: (){

                                     Navigator.push(context, MaterialPageRoute(
                                         builder: (context)=> replies_page(question_id: docSnap.documentID,)
                                     )
                                     );

                                 },
                               ),

                               RaisedButton(
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                 onPressed: (){},
                                 color: Colors.deepPurple,
                                 splashColor: Colors.deepPurple[400],
                                 child: Text('Follow',
                                 style: TextStyle(
                                   color: Colors.white
                                 ),
                                 ),
                               )
                             ],
                           )
                         ],
                       ),
                     );
                    } ,
                  );
                }
            },
          )
        ),
      ),
    );
  }
}
