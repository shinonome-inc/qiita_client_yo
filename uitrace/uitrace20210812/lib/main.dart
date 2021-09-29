import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


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
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 30.0),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ),
          Container(
            child: Image.asset('assets/image.png'),
          ),
          Container(
            //color: Colors.amberAccent,
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              "If they're there, we'll find 'em",
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            //color: Colors.amberAccent,
            margin: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 50.0),
            alignment: Alignment.center,
            child: Text(
              'SeatGreek brings together tickets from hundreds of sites to save you time and money',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  '●   ',
                  style: TextStyle(
                    fontSize: 6.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '●   ',
                  style: TextStyle(
                    fontSize: 6.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '●',
                  style: TextStyle(
                    fontSize: 6.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(15.0),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('Sign up'),
                textColor: Colors.white,
                color: Colors.blueAccent,
                padding: EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
              ),
              FlatButton(
                onPressed: () {},
                child: Text('Log in'),
                textColor: Colors.white,
                color: Colors.blueAccent,
                padding: EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.all(5.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
                'Terms of Use ｜ Privacy Policy',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
