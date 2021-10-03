import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyWork {
  String text = '';
  String image = '';
  bool isTop = false;
  bool isBottom = false;

  MyWork({ required this.text, required this.image, required this.isTop, required this.isBottom });

  Widget myWorkItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isTop ? BorderRadius.vertical(top: Radius.circular(5.0)) : (isBottom ? BorderRadius.vertical(bottom: Radius.circular(5.0)) : BorderRadius.zero),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset('assets/${this.image}.png'),
              SizedBox(width: 10.0),
              Text(
                this.text,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.grey[400],
            size: 15.0,
          ),
        ],
      ),
    );
  }

}