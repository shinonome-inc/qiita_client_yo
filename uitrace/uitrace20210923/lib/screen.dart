import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  Widget colorfulContainer(Color? boxColor, Color? itemColor, String text) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: boxColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: itemColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios),
            color: itemColor,
            iconSize: 20.0,
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
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.settings_outlined),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Merriweather',
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'C',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          TextSpan(
                            text: 'ocoon',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40.0),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Welcome to Cocoon!',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.add_circle,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 200.0,
                          child: Text(
                            'Watch this video for a quick tour of the app. You can dismiss it at any time.',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Image.asset('assets/image.png'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Start a Cocoon',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Choose a template to get started',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    colorfulContainer(Colors.purple[100], Colors.purple[400], 'Family'),
                    colorfulContainer(Colors.indigo[100], Colors.indigo[300], 'Close Friends'),
                    colorfulContainer(Colors.lightGreen[100], Colors.green[300], 'Couple'),
                    colorfulContainer(Colors.yellow[100], Colors.amber[400], 'Just Testing'),
                    colorfulContainer(Colors.pink[50], Colors.pink[200], 'Other'),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
