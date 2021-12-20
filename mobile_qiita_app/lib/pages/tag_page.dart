import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/services/tag.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  late Future<List<Tag>> _futureTag;

  //
  Widget _tagWidget(Tag tag) {
    return GestureDetector(
      onTap: () {
        print(tag.id);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.5,
          ),
        ),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50.0,
                width: 50.0,
                child: tag.icon_url == '' ? Container(color: Colors.transparent) : Image.network(tag.icon_url),
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
                ),
              ),
              Text(
                'フォロワー数: ${tag.followers_count}',
                style: TextStyle(
                  color: const Color(0xFF828282),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _futureTag = Client.fetchTag();
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
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Pacifico',
            fontSize: 20.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
          child: FutureBuilder(
            future: _futureTag,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> children = [];
              MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
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
                      itemBuilder: (BuildContext context, int index) => _tagWidget(snapshot.data[index]),
                    ),
                  ),
                ];
              }
              else if (snapshot.hasError) {
                print(snapshot.error);
                children = [
                  Text(snapshot.error.toString()),
                ];
              }
              else {
                mainAxisAlignment = MainAxisAlignment.center;
                children = [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ];
              }
              return Column(
                mainAxisAlignment: mainAxisAlignment,
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }
}
