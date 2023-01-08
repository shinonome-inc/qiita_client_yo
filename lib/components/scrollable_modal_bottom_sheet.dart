import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/app_border_radius.dart';
import 'package:mobile_qiita_app/common/constants.dart';

/// Shows a scrollable modal Cupertino Design bottom sheet.
void showScrollableModalBottomSheet({
  required BuildContext context,
  required String headerText,
  required Widget child,
}) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: AppBorderRadius.modalHeaderBorderRadius,
    ),
    builder: (context) {
      return ScrollableModalBottomSheet(
        headerText: headerText,
        child: child,
      );
    },
  );
}

/// Creates a widget that can be scrollable modal bottom sheet.
class ScrollableModalBottomSheet extends StatelessWidget {
  const ScrollableModalBottomSheet({
    Key? key,
    required this.headerText,
    required this.child,
  }) : super(key: key);

  final String headerText;
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
            ScrollableModalBottomSheetHeader(
              headerText: headerText,
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

/// Creates a header for the scrollable modal bottom sheet.
class ScrollableModalBottomSheetHeader extends StatelessWidget {
  const ScrollableModalBottomSheetHeader({
    Key? key,
    required this.headerText,
  }) : super(key: key);

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 11.0),
      alignment: Alignment.bottomCenter,
      height: 59.0,
      decoration: const BoxDecoration(
        color: Color(0xF0F9F9F9),
        borderRadius: AppBorderRadius.modalHeaderBorderRadius,
      ),
      child: Text(
        headerText,
        style: const TextStyle(
          fontSize: 17.0,
          color: Color(0xFF000000),
          fontFamily: Constants.pacifico,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
