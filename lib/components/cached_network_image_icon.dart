import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

class CachedNetworkImageIcon extends StatefulWidget {
  const CachedNetworkImageIcon({
    required this.imageUrl,
    this.iconLength = 48.0,
    this.isTagIcon = false,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final double iconLength;
  final bool isTagIcon;

  @override
  _CachedNetworkImageIconState createState() => _CachedNetworkImageIconState();
}

class _CachedNetworkImageIconState extends State<CachedNetworkImageIcon> {
  BoxDecoration _boxDecoration({required ImageProvider<Object> image}) {
    return BoxDecoration(
      shape: widget.isTagIcon ? BoxShape.rectangle : BoxShape.circle,
      image: DecorationImage(
        image: image,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.iconLength,
      height: widget.iconLength,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: _boxDecoration(image: imageProvider),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Container(
            decoration: _boxDecoration(
              image: NetworkImage(
                widget.isTagIcon
                    ? Constants.defaultTagIconUrl
                    : Constants.defaultUserIconUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
