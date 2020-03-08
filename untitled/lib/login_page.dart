import 'package:flutter/material.dart';
class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Card(
          child: Form(
            child: Row(
              children: <Widget>[
                TextFormField(
                  validator: (input){},
                  onSaved: null,
                  decoration: InputDecoration(labelText: 'Password',
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.deepPurple,
                      )
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
