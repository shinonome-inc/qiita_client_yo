import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/rounded_text_button.dart';

// ネットワークエラー
class NetworkErrorView extends StatelessWidget {
  const NetworkErrorView({required this.onTapReload, Key? key})
      : super(key: key);

  final Function() onTapReload;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 66.67,
                    width: 66.67,
                    child: Image.asset(
                      'assets/images/network_error.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 42.67, bottom: 6.0),
                    child: const Text('ネットワークエラー'),
                  ),
                  const Text(
                    'お手数ですが電波の良い場所で\n再度読み込みをお願いします',
                    style: TextStyle(
                      color: Constants.lightSecondaryGrey,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            RoundedTextButton(
              onPressed: onTapReload,
              buttonText: '再読み込みする',
              backgroundColor: Constants.lightSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
