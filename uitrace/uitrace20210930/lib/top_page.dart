import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitrace20210930/my_work.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final issue = new MyWork(text: 'Issue', image: 'issues', isTop: true, isBottom: false);
  final pullRequests = new MyWork(text: 'Pull Requests', image: 'pullRequests', isTop: false, isBottom: false);
  final repositories = new MyWork(text: 'Repositories', image: 'repositories', isTop: false, isBottom: false);
  final organizations = new MyWork(text: 'Organizations', image: 'organizations', isTop: false, isBottom: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blueGrey[50],
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset('assets/user_icon.png'),
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue,
                  )
                ],
              ),
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My Work',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          issue.myWorkItem(),
                          pullRequests.myWorkItem(),
                          repositories.myWorkItem(),
                          organizations.myWorkItem(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Favorites',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Edit'),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(214, 215, 219, 1.0),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Add favorite repositories here to have quick access at any time, without having to search',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          FlatButton(
                            onPressed: () {},
                            child: Container(
                              width: 450.0,
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Text(
                                'Add Favorites',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
