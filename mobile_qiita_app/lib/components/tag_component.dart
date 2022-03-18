import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/pages/tag_detail_list_page.dart';

class TagComponent extends StatelessWidget {
  const TagComponent({required this.tag, Key? key}) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Constants.gray5,
          width: 1.0,
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TagDetailListPage(tag: tag),
            ),
          );
        },
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 38.0,
              width: 38.0,
              child: CachedNetworkImage(imageUrl: tag.iconUrl),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              width: 130.0,
              height: 20.0,
              child: Text(
                tag.id,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              '記事件数: ${tag.itemsCount}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Constants.lightSecondaryGrey,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'フォロワー数: ${tag.followersCount}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Constants.lightSecondaryGrey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
