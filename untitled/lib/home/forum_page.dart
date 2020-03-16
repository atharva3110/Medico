import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/home/chatsForums.dart';


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

                             Text(docSnap['likes']),

                             IconButton(
                               icon: Icon(Icons.comment),
                               onPressed: (){

                               },
                             ),

                             IconButton(
                               icon: Icon(Icons.share),
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
    );
  }
}
