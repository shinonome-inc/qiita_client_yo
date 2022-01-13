import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/services/tag.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/constants.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  late Future<List<Tag>> _futureTags;

  // 取得したタグの内容を整理して表示
  Widget _tagWidget(Tag tag) {
    String tagIconUrl = tag.icon_url;
    if (tagIconUrl.isEmpty) {
      tagIconUrl = Constants.defaultUserIconUrl;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.5,
        ),
      ),
      child: ListTile(
        onTap: () {
          // TODO: タグをタップして遷移
        },
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              child: CachedNetworkImage(imageUrl: tagIconUrl),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                tag.id,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '記事件数: ${tag.items_count}',
              style: TextStyle(
                color: const Color(0xFF828282),
                fontSize: 13.5,
              ),
            ),
            Text(
              'フォロワー数: ${tag.followers_count}',
              style: TextStyle(
                color: const Color(0xFF828282),
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 再読み込みする
  void _reload() {
    setState(() {
      _futureTags = Client.fetchTag();
    });
  }

  @override
  void initState() {
    super.initState();
    _futureTags = Client.fetchTag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Tag',
          style: Constants.headerTextStyle,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
          child: FutureBuilder(
            future: _futureTags,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> children = [];
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  children = [
                    Flexible(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                        ),
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => _tagWidget(snapshot.data[index]),
                      ),
                    ),
                  ];
                }
                else if (snapshot.hasError) {
                  children = [
                    ErrorView.errorViewWidget(_reload),
                  ];
                }
              }
              else {
                children = [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ];
              }
              return Column(
                mainAxisAlignment: snapshot.connectionState == ConnectionState.done
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }
}
