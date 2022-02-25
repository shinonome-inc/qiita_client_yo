import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/pages/follows_followers_list_page.dart';

class FollowsFollowersButton extends StatelessWidget {
  const FollowsFollowersButton({
    required this.user,
    required this.usersType,
    Key? key,
  }) : super(key: key);

  final User user;
  final String usersType;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> buttonLabelNumber = {
      'Follows': user.followingsCount.toString(),
      'Followers': user.followersCount.toString(),
    };
    final Map<String, String> buttonLabelText = {
      'Follows': 'フォロー中',
      'Followers': 'フォロワー',
    };

    return Container(
      height: 24.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FollowsFollowersListPage(
                usersType: usersType,
                userId: user.id,
              ),
            ),
          );
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: buttonLabelNumber[usersType],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: buttonLabelText[usersType],
                style: TextStyle(
                  color: Constants.lightSecondaryGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
