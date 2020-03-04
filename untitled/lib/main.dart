import 'package:flutter/material.dart';


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
              image: AssetImage('assets/login/login-with-facebook-button-png-5.jpg'),
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
            child: Image(
              image: AssetImage('assets/login/supervised_user_circle-24px.jpg'),
            ),
          ),
          SizedBox(height: 10),
          new Row(
            children: <Widget>[

              SizedBox(width: 200),
              new Text('Or'),
            ],
          ),
          SizedBox(height: 25),
          new Container(
            child: Image(
              image: AssetImage('assets/login/email.jpg'),
            ),
          )
        ],
        ),
      );

     }

}