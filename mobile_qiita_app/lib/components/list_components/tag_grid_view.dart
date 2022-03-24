import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/tag_component.dart';
import 'package:mobile_qiita_app/models/tag.dart';

// タグ一覧をGridViewで表示
class TagGridView extends StatefulWidget {
  TagGridView({
    required this.tags,
    required this.scrollController,
    required this.numOfTagsPerLine,
    Key? key,
  }) : super(key: key);

  final List<Tag> tags;
  final ScrollController scrollController;
  final int numOfTagsPerLine;

  @override
  _TagGridViewState createState() => _TagGridViewState();
}

class _TagGridViewState extends State<TagGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.numOfTagsPerLine,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          controller: widget.scrollController,
          itemCount: widget.tags.length,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return TagComponent(tag: widget.tags[index]);
          }),
    );
  }
}
