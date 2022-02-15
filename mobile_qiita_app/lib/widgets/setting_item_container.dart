import 'package:flutter/material.dart';

class SettingItemContainer extends StatelessWidget {
  const SettingItemContainer({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFFE0E0E0),
              width: 1.6,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
