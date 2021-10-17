import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({Key? key}) : super(key: key);

  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  List<bool?> flags = [true, true, true, false];

  Widget checkContainer(String title, String text, int index) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 30.0),
          Transform.scale(
            scale: 1.4,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              activeColor: Color.fromRGBO(137, 200, 90, 1.0),
              value: flags[index],
              onChanged: (bool? e) {
                setState(() {
                  flags[index] = e;
                });
              },
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Choose your subscription',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          SizedBox(width: 40.0),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Container(
             padding: EdgeInsets.only(top: 65.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Personal',
                              style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '3\$/month',
                              style: TextStyle(
                                color: Color.fromRGBO(137, 200, 90, 1.0),
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            checkContainer('Invest', 'Investment account', 0),
                            checkContainer('Later', 'Retirement account', 1),
                            checkContainer('Banking', 'Checking account', 2),
                            checkContainer('Early', 'kid\'s investment account(UGMA)', 3),
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        color: Color.fromRGBO(137, 200, 90, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 75.0),
                          child: Text(
                            'Choose this plan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 50.0),
              child: FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {},
                child: Container(
                  width: 100.0,
                  child: Text(
                    'All-in-one',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
