import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/constants.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/widgets/tag_widget.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Tag>> _futureTags;
  List<Tag> _fetchedTags = [];
  late int _tagContainerLength;
  int _currentPageNumber = 1;
  bool _isNetworkError = false;
  bool _isLoading = false;

  // 取得したタグ一覧をGridViewで表示
  Widget _tagGridView() {
    return RefreshIndicator(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _tagContainerLength,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        controller: _scrollController,
        itemCount: _fetchedTags.length,
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            TagWidget.tagWidget(context, _fetchedTags[index]),
      ),
      onRefresh: _reload,
    );
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureTags = Client.fetchTag(_currentPageNumber);
    });
  }

  // タグを追加読み込み
  Future<void> _moreLoad() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureTags = Client.fetchTag(_currentPageNumber);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _futureTags = Client.fetchTag(_currentPageNumber);
    _scrollController.addListener(() {
      if (_scrollController.isBottom) {
        _moreLoad();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tagContainerLength = (MediaQuery.of(context).size.width ~/ 192).toInt();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 1.6,
        title: const Text(
          'Tag',
          style: Constants.headerTextStyle,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: _futureTags,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget child = Container();

              if (snapshot.hasError) {
                _isNetworkError = true;
                child = ErrorView.networkErrorView(_reload);
              } else if (_currentPageNumber != 1) {
                child = _tagGridView();
              }

              if (snapshot.connectionState == ConnectionState.done) {
                _isLoading = false;
                if (snapshot.hasData) {
                  _isNetworkError = false;
                  if (_currentPageNumber == 1) {
                    _fetchedTags = snapshot.data;
                    child = _tagGridView();
                  } else {
                    _fetchedTags.addAll(snapshot.data);
                  }
                } else if (snapshot.hasError) {
                  child = ErrorView.networkErrorView(_reload);
                }
              } else {
                if (_isNetworkError || _currentPageNumber == 1) {
                  child = CircularProgressIndicator();
                }
              }

              return Container(
                child: Center(
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
