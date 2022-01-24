import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorView {
  static Widget errorViewWidget(Function onTapReload) {
    return Expanded(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child: Image.asset(
                        'assets/images/network_error.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                      child: const Text(
                        'ネットワークエラー',
                      ),
                    ),
                    const Text(
                      'お手数ですが電波の良い場所で\n再度読み込みをお願いします',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  onTapReload();
                },
                height: 45.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                )),
                child: const Text(
                  '再読み込みする',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
