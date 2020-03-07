import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/home/homePage.dart';

import 'home/homePage.dart';



void main() => runApp(MyApp());

Map<int, Color> color =
{
  50:Color.fromRGBO(2,0,97, .1),
  100:Color.fromRGBO(2,0,97, .2),
  200:Color.fromRGBO(2,0,97, .3),
  300:Color.fromRGBO(2,0,97, .4),
  400:Color.fromRGBO(2,0,97, .5),
  500:Color.fromRGBO(2,0,97, .6),
  600:Color.fromRGBO(2,0,97, .7),
  700:Color.fromRGBO(2,0,97, .8),
  800:Color.fromRGBO(2,0,97, .9),
  900:Color.fromRGBO(2,0,97, 1),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    MaterialColor colorCustom = MaterialColor(0xFF020061, color);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: colorCustom,
        bottomAppBarColor: colorCustom
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

class SignUp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            child: Image(
              image: AssetImage('assets/login/Signup_bg.jpg'),
            ),
          ),
          SizedBox(height: 20),
          new Container(
            child: Image(
              image: AssetImage(
                  'assets/login/login-with-facebook-button-png-5.jpg'),
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

              SizedBox(width: 200),
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
                      String _email, _password;
                      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

                      void signIn() async {

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => homePage()));

                        final FormState formState=_formKey.currentState;
                        if(formState.validate()) {
                          formState.save();
                          try {
                            FirebaseUser user = FirebaseAuth.instance
                                .createUserWithEmailAndPassword(email: _email,
                                password: _password) as FirebaseUser;
                          }
                          catch (e) {
                            print(e.message);
                          }
                        }
                      }
                      return Scaffold(/* Redirects user to login from*/

                        appBar: AppBar(
                          title: Text('Login with email'),
                        ),
                        body: (
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
                              child: (
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return "Email field is empty";
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                          onSaved: (input) => _email = input,
                                          decoration: InputDecoration(
                                              labelText: 'Email ID'

                                          ),
                                        ),

                                        TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty)
                                            {
                                              return "Password field is empty";
                                            }
                                            if(input.length<6)
                                            {
                                                return "Password must be atleast 6 characters long";
                                            }
                                            else
                                              {
                                                return null;
                                              }
                                          },
                                          onSaved: (input) => _password = input,
                                          decoration: InputDecoration(
                                              labelText: 'Password'

                                          ),
                                          obscureText: true,
                                        ),
                                        SizedBox(height: 30),

                                        RaisedButton(
                                          onPressed: signIn,
                                          textColor: Colors.white,
                                          child: Text('Siginup'),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            )
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
    );

  }
}