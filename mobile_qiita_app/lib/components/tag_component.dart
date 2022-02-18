import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
          color: const Color(0xFFE0E0E0),
          width: 1.6,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 48.0,
              width: 48.0,
              child: CachedNetworkImage(imageUrl: tag.iconUrl),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                tag.id,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '記事件数: ${tag.itemsCount}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF828282),
                fontSize: 14.5,
              ),
            ),
            Text(
              'フォロワー数: ${tag.followersCount}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF828282),
                fontSize: 14.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
