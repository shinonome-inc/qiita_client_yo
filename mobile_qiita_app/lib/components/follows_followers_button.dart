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

  void _transitionToUserList(BuildContext context, int numOfUsers) {
    if (numOfUsers == 0) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FollowsFollowersListPage(
          usersType: usersType,
          userId: user.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int numOfUsers = 0;
    String buttonText = '';
    bool isFollows = (usersType == 'Follows');
    bool isFollowers = (usersType == 'Followers');

    if (isFollows) {
      numOfUsers = user.followingsCount;
      buttonText = 'フォロー中';
    } else if (isFollowers) {
      numOfUsers = user.followersCount;
      buttonText = 'フォロワー';
    }

    return Container(
      height: 24.0,
      child: InkWell(
        onTap: () {
          _transitionToUserList(context, numOfUsers);
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: numOfUsers.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: buttonText,
                style: TextStyle(color: Constants.lightSecondaryGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
