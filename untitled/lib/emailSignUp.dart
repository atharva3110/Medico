import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/home/homePage.dart';
class emailSignUp extends StatefulWidget {
  @override
  _emailSignUpState createState() => _emailSignUpState();
}

class _emailSignUpState extends State<emailSignUp> {

  String userId;
  String _email, _firstName, _phoneNumber, _age,
  _password, _confirmPass;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final databasereference=Firestore.instance;

  void signIn() async {
  //signin function

  final FormState formState = _formKey.currentState;
  if (formState.validate()) {
  formState.save();
  try {

    FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;

    userId=user.uid;

    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>homePage(user: user,)
    ));
  }
  catch (e) {
  print(e.message);
  }
  Firestore.instance.collection("Users").document(userId).setData(
      {
        'name': _firstName,
        'email': _email,
        'phoneNumber': _phoneNumber
      });
  }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(/* Redirects user to login from*/

      appBar: AppBar(
        title: Text('Login with email'),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Card(
          elevation: 7,
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
                          TextFormField( //Name


                            validator: (input) {
                              if (input.isEmpty) {
                                return "Name cannot be empty";
                              }
                              else {
                                return null;
                              }
                            },
                            onSaved: (input) =>
                            _firstName = input,
                            decoration: InputDecoration(
                                labelText: 'Name',

                                icon: Icon(
                                  Icons.account_circle,
                                  color: Colors.deepPurple
                                  ,)

                            ),

                          ),
                          TextFormField( //Phone Number


                            validator: (input) {
                              if (input.isEmpty) {
                                return "Phone Number cannot be empty";
                              }
                              else {
                                return null;
                              }
                            },
                            onSaved: (input) =>
                            _phoneNumber = input,
                            decoration: InputDecoration(
                                labelText: 'Phn Number',

                                icon: Icon(Icons.phone,
                                  color: Colors.deepPurple
                                  ,)

                            ),
                            keyboardType: TextInputType
                                .number,

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


                          TextFormField(

                            validator: (input) {
                              if (identical(
                                  _password.toString(),
                                  _confirmPass
                                      .toString()) ==
                                  false) {
                                return "Passwords does not match";
                              }
                              else {
                                return null;
                              }
                            },
                            onSaved: (input) =>
                            _confirmPass = input,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                icon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.deepPurple,)

                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 20,),

                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius
                                    .circular(18)
                            ),
                            onPressed: signIn,
                            padding: EdgeInsets.fromLTRB(
                                50, 10, 50, 10),
                            textColor: Colors.white,
                            color: Colors.deepPurple,
                            child: Text('Siginup',
                              style: TextStyle(
                                letterSpacing: 2.0,
                              ),),
                          ),
                          SizedBox(height: 10,)

                        ],
                      ),
                    )
                ),
              )
          ),

        ),

      ),
    );
  }
}

