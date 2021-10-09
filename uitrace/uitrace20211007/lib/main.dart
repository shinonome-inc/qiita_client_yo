import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool active1 = true;
  bool active2 = false;
  bool active3 = false;

  Widget containerWidget(String title, String text, IconData iconData, bool active) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(iconData),
                    SizedBox(width: 5.0),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: active,
            onChanged: (bool value) {
              setState(() {
                active = value;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'App Permissions',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                      child: Text(
                        'One last thing! You\'ll need to grant the following app permissions to enable the features you\'ve chosen:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          wordSpacing: 1.0,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    containerWidget('Notifications', 'For important activity that takes place in your Cocoon', Icons.chat_outlined, active1),
                    containerWidget('Location', 'Required to power your map, and precise or city-level updates', Icons.home_outlined, active2),
                    containerWidget('Activity', 'Enable activity from the Health app to be shared into Cocoon', Icons.sports_handball_outlined, active3),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  children: [
                    TextSpan(
                      text: 'You can always adjust these later from within the ',
                    ),
                    TextSpan(
                      text: 'Setting app.',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              FlatButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                height: 55.0,
                color: Colors.blue[700],
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}