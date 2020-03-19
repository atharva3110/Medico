import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/doctorHomePage/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class docLoginPage extends StatefulWidget {
  @override
  _docLoginPageState createState() => _docLoginPageState();
}

class _docLoginPageState extends State<docLoginPage> {
  String _email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginUser() async {
    //login function

    final FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        Firestore firestore;
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>homePage(user: user,)
            ));

      }
      catch (e) {
        print(e.message);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Login'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 110, 30, 0),

        child: Column(
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: (
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 25, 40, 0),
                    child: (
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[

                              TextFormField( //email


                                validator: (input) {
                                  if (input.isEmpty) {
                                    return "Email field is empty";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                onSaved: (input) =>
                                _email = input,
                                decoration: InputDecoration(
                                    labelText: 'Email ID',

                                    icon: Icon(Icons.mail,
                                      color: Colors.deepPurple
                                      ,)

                                ),

                              ),

                              TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return "Password field is empty";
                                  }
                                  if (input.length < 6) {
                                    return "Password must be atleast 6 characters long";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                onSaved: (input) {
                                  _password = input;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.deepPurple,)
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 30,)
                            ],
                          ),
                        )
                    ),
                  )
              ),
            ),
            SizedBox(height: 20,),
            RaisedButton (
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .circular(18)
              ),
              onPressed: loginUser,
              padding: EdgeInsets.fromLTRB(
                  50, 10, 50, 10),
              textColor: Colors.white,
              color: Colors.deepPurple,
              child: Text('Login',
                style: TextStyle(
                  letterSpacing: 2.0,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
