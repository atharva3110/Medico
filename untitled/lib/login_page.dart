import 'package:flutter/material.dart';
import 'package:untitled/docLoginPage.dart';
import 'package:untitled/main.dart';
import 'package:untitled/docLoginPage.dart';
import 'package:untitled/home/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  String _email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginUser() async {
                                                                       //login function

    final FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {

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
        title: Text('Login with email'),
        backgroundColor: Colors.deepPurple[400],
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



                              SizedBox(height: 20,),


                              SizedBox(height: 10,)

                            ],
                          ),
                        )
                    ),
                  )
              ),

            ),
            SizedBox(height: 10,),
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
            SizedBox(height: 15,),
            Text('OR'),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                SizedBox(width: 49,),
                Text("Create a new account?",
                style: TextStyle(
                  color: Colors.blueGrey
                ),
                ),
                SizedBox(width: 5,),

                GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));},
                  child: Text("Signup",
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),

            RaisedButton (
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .circular(18)
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>docLoginPage()));
              },
              padding: EdgeInsets.fromLTRB(
                  50, 10, 50, 10),
              textColor: Colors.white,
              color: Colors.deepPurple,
              child: Text('Login as doctor',
                style: TextStyle(
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ],
        ),



      ),
    );
  }
}
