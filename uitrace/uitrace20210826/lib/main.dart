import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '×',
                    style: TextStyle(
                      fontSize: 60.0,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(width: 30.0),
                  Image.asset('assets/bar.png'),
                  SizedBox(width: 30.0),
                  Image.asset('assets/heart.png'),
                  Text(
                    '5',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/purple_icon.png'),
                    Text(
                      ' NEW WORD',
                      style: TextStyle(
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Which of these is "coffee"?',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                ),
              ),
              Row(
                children: <Widget>[
                  illustrationCard('assets/milch.png', 'Milch'),
                  illustrationCard('assets/brot.png', 'Brot'),
                ],
              ),
              Row(
                children: <Widget>[
                  illustrationCard('assets/wasser.png', 'wasser'),
                  illustrationCard('assets/kaffee.png', 'kaffee'),
                ],
              ),

              FlatButton(
                color: Colors.grey[300],
                padding: EdgeInsets.fromLTRB(150.0, 10.0, 150.0, 10.0),
                onPressed: () {},
                child: Text(
                    'CHECK',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget illustrationCard(String image, String word) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Image.asset(image),
              SizedBox(height: 20.0),
              Text(word),
            ],
          ),
        ),
      ),
    );
  }
}