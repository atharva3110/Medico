import 'package:flutter/material.dart';
import 'package:untitled/doctorHomePage/homePage.dart';
import 'package:untitled/home/forum_page.dart';
import 'package:untitled/home/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class post_question extends StatefulWidget {
  @override
  _post_questionState createState() => _post_questionState();
}

class _post_questionState extends State<post_question> {
  String _question;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Question'
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            TextField(
              onChanged: (input)=>_question=input,
              decoration: InputDecoration(
                hintText: 'Enter your question'
              ),
            ),
            RaisedButton(
              onPressed: (){
                Firestore.instance.collection('Forum').add({
                  'question': "Q:"+ _question,
                  'replies': 0,
                  /* pass user id from local storage*/
                  'likes': 0
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>forum_page()));
              },
              color: Colors.deepPurple,
              child: Text('Post',
              style: TextStyle(
                color: Colors.white
              ),
              ),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
            )
          ],
        ),
      ),
    );
  }
}
