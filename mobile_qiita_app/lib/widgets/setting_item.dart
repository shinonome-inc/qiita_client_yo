import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/widgets/setting_item_container.dart';

class SettingItem extends StatelessWidget {
  const SettingItem(
      {required this.settingTitle, required this.settingItem, Key? key})
      : super(key: key);
  final String settingTitle;
  final Widget settingItem;
  @override
  Widget build(BuildContext context) {
    return SettingItemContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(settingTitle),
          settingItem,
        ],
      ),
    );
  }
}
