import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

class RoundedTextButton extends StatelessWidget {
  const RoundedTextButton({
    required this.onPressed,
    required this.buttonText,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;
  final String buttonText;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      style: TextButton.styleFrom(
        minimumSize: Size(
          /* width  */ MediaQuery.of(context).size.width - 48,
          /* height */ 50,
        ),
        backgroundColor: backgroundColor,
        primary: Constants.roundedTextButtonPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
