import 'package:flutter/cupertino.dart';

extension PaginationScroll on ScrollController {
  bool get isBottom {
    return position.pixels >= position.maxScrollExtent;
  }
}
