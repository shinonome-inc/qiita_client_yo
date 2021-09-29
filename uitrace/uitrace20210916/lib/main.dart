import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';

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
  List<Widget> iconList = [
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.fastfood,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.fastfood,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.fastfood,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.fastfood,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.fastfood,
      ),
    ),
  ];

  Widget card() {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Image.asset('assets/hamburger.png'),
                Text(
                  'Avocado Bacon Burger',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  'Cheeseburger topped with freshly sliced avocado, Numan Ranch applewood-smoked bacon ShackSauce',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '\$7.89',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('610 cal',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ListView
  // sliber

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.grey[800],
            size: 35.0,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pick-Up from',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              '6201 Hollywood (cross st...',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.dehaze_sharp,
              color: Colors.grey[800],
              size: 25.0,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView(
                scrollDirection: Axis.horizontal,
                children: iconList,
              ),
              SizedBox(height: 50.0),
              Text(
                'Burgers',
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                'No hormones or antibiotics ever, our 100% Angus beef is humanely raised and grazed in the USA',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.0,),
              // ListView(
              //   shrinkWrap: true,
              //   children: <Widget>[
              //     Text('hello'),
              //     Text('hello'),
              //     Text('hello'),
              //     Text('hello'),
              //     Text('hello'),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
