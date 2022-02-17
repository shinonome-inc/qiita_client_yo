import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/extension/connection_state_done.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/widgets/view_formats.dart';

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
  final String _appBarTitle = 'Tag';

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureTags = QiitaClient.fetchTag(_currentPageNumber);
    });
  }

  // タグを追加読み込み
  Future<void> _moreLoad() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureTags = QiitaClient.fetchTag(_currentPageNumber);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _futureTags = QiitaClient.fetchTag(_currentPageNumber);
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
      appBar: AppBarComponent(title: _appBarTitle, useBackButton: false),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 16.0),
          child: FutureBuilder(
            future: _futureTags,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget child = Container();

              if (snapshot.hasError) {
                _isNetworkError = true;
                child = ErrorView.networkErrorView(_reload);
              } else if (_currentPageNumber != 1) {
                child = ViewFormats.tagGridView(_reload, _fetchedTags,
                    _scrollController, _tagContainerLength);
              }

              if (snapshot.connectionStateDone && snapshot.hasData) {
                _isLoading = false;
                _isNetworkError = false;
                if (_currentPageNumber == 1) {
                  _fetchedTags = snapshot.data;
                  child = ViewFormats.tagGridView(_reload, _fetchedTags,
                      _scrollController, _tagContainerLength);
                } else {
                  _fetchedTags.addAll(snapshot.data);
                }
              } else if (snapshot.hasError) {
                _isNetworkError = true;
                child = ErrorView.networkErrorView(_reload);
              } else if (_isNetworkError || _currentPageNumber == 1) {
                child = CircularProgressIndicator();
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
