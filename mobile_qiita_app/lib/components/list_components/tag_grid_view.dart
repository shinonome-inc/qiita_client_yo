import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/tag_component.dart';
import 'package:mobile_qiita_app/models/tag.dart';

// タグ一覧をGridViewで表示
class TagGridView extends StatefulWidget {
  TagGridView({
    required this.onTapReload,
    required this.tags,
    required this.scrollController,
    required this.tagContainerLength,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onTapReload;
  final List<Tag> tags;
  final ScrollController scrollController;
  final int tagContainerLength;

  @override
  _TagGridViewState createState() => _TagGridViewState();
}

class _TagGridViewState extends State<TagGridView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.tagContainerLength,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            controller: widget.scrollController,
            itemCount: widget.tags.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return TagComponent(tag: widget.tags[index]);
            }),
      ),
      onRefresh: widget.onTapReload,
    );
  }
}
