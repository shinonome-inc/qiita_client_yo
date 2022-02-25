import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

class AppBarComponent extends StatelessWidget with PreferredSizeWidget {
  const AppBarComponent(
      {required this.title, required this.useBackButton, Key? key})
      : super(key: key);

  final String title;
  final bool useBackButton;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: useBackButton
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Constants.lightPrimaryColor,
              ),
            )
          : Container(),
      backgroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 1.6,
      title: Text(
        title,
        style: Constants.appBarTextStyle,
      ),
    );
  }
}
