import 'package:flutter/material.dart';

class NetworkErrorView extends StatelessWidget {
  const NetworkErrorView({required this.onTapReload, Key? key})
      : super(key: key);

  final Function() onTapReload;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 72.0,
                    width: 72.0,
                    child: Image.asset(
                      'assets/images/network_error.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40.0, bottom: 8.0),
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
              height: 48.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24.0),
                ),
              ),
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
    );
  }
}
