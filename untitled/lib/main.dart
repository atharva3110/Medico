
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/home/homePage.dart';
import 'package:firebase_database/firebase_database.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login/main_bg.jpg'), fit: BoxFit.cover
        )
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Scaffold(
        body: new Column(
          children: <Widget>[

            new Container(
              child: Image(
                image: AssetImage('assets/login/Signup_bg.jpg'),
              ),
            ),
            SizedBox(height: 20),
            new Container(
              child: GestureDetector(
                onTap: () {},

                child: Image(
                  image: AssetImage(
                      'assets/login/login-with-facebook-button-png-5.jpg'),
                ),
              ),
            ),
            SizedBox(height: 20),
            new Container(
              child: Image(
                image: AssetImage('assets/login/google.jpg'),
              ),
            ),
            SizedBox(height: 20),
            new Container(
              child: GestureDetector(
                onTap: () {},
                child: Image(
                  image: AssetImage(
                    'assets/login/supervised_user_circle-24px.jpg',),

                ),
              ),
            ),
            SizedBox(height: 10),
            new Row(
              children: <Widget>[
                SizedBox(width: 170),
                new Text('Or'),
              ],
            ),

            new Container(
              child: RaisedButton.icon(
                icon: Icon(Icons.mail),
                label: Text('Mail'),
                color: Colors.amber,
                splashColor: Colors.amber,
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) {
                        String _email, _firstName, _phoneNumber, _age,
                            _password, _confirmPass;
                        FirebaseDatabase db= new FirebaseDatabase();
                        DatabaseReference _ref=db.  reference().child("Users");


                        final GlobalKey<FormState> _formKey = GlobalKey<
                            FormState>();
                        FormState fs = _formKey.currentState;
                        void signIn() async {
                          //signin function

                          final FormState formState = _formKey.currentState;
                          if (formState.validate()) {
                            formState.save();
                            try {
                              _ref.push().child("UserData").set({                      //adding form data to database
                                'Name': _firstName,
                                "EmailID": _email,
                                "PhoneNumber": _phoneNumber
                              });

                              FirebaseUser user = FirebaseAuth.instance               //creating new user
                                  .createUserWithEmailAndPassword(email: _email,
                                  password: _password) as FirebaseUser;
                              FirebaseAuth.instance.signOut();

                              //Code to redirect to login page

                            }
                            catch (e) {
                              print(e.message);
                            }
                          }
                        }


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
                      )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}