import 'package:flutter/material.dart';

class SettingsItemComponent extends StatelessWidget {
  const SettingsItemComponent(
      {required this.onTap, required this.title, required this.item, Key? key})
      : super(key: key);

  final Function() onTap;
  final Text title;
  final Widget item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.0,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFFE7E7E7),
                width: 1.6,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              title,
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: item,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
