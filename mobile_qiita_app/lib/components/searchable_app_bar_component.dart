import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

class SearchableAppBarComponent extends StatelessWidget
    with PreferredSizeWidget {
  const SearchableAppBarComponent(
      {required this.title, required this.searchArticles, Key? key})
      : super(key: key);

  final String title;
  final void Function(String) searchArticles;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 46.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFFCFCFCF),
                width: 0.2,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Center(
                    child: Text(
                      title,
                      style: Constants.appBarTextStyle,
                    ),
                  ),
                ),
              ),
              Container(
                height: 36.0,
                margin:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                padding: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xEFEFF0FF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  enabled: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF8E8E93),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: const Color(0xFF8E8E93),
                      fontSize: 17.0,
                    ),
                  ),
                  onSubmitted: searchArticles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
