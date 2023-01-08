import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

class ScrollableModalBottomSheet extends StatelessWidget {
  /// Creates a widget that can be scrollable modal bottom sheet.
  const ScrollableModalBottomSheet({
    Key? key,
    required this.headerTitle,
    required this.child,
  }) : super(key: key);

  final String headerTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.96,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 26.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.0),
                ),
                color: Color(0xF0F9F9F9),
              ),
              height: 59.0,
              child: Text(
                headerTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 17.0,
                  fontFamily: Constants.pacifico,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
