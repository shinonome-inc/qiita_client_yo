import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

class ScrollableModalBottomSheet extends StatelessWidget {
  /// Creates a widget that can be scrollable modal bottom sheet.
  const ScrollableModalBottomSheet({
    Key? key,
    required this.headerTitle,
    required this.child,
    required this.statusBarHeight,
  }) : super(key: key);

  final String headerTitle;
  final Widget child;
  final double statusBarHeight;

  double _calculateInitialChildSize(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double modalHeight = deviceHeight - statusBarHeight - 11.0;
    return modalHeight / deviceHeight;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: _calculateInitialChildSize(context),
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScrollableModalBottomSheetHeader(
              title: Text(headerTitle),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

class ScrollableModalBottomSheetHeader extends StatelessWidget {
  const ScrollableModalBottomSheetHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      titleTextStyle: const TextStyle(
        fontSize: 17.0,
        color: Color(0xFF000000),
        fontFamily: Constants.pacifico,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: const Color(0xF0F9F9F9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
