import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

// スクロール可能なModalBottomSheet
class ModalBottomSheetComponent extends StatelessWidget {
  const ModalBottomSheetComponent({
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
        return Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24.0),
                  ),
                  color: const Color(0xF0F9F9F9),
                ),
                height: 59.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Text(
                    headerTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: const Color(0xFF000000),
                      fontSize: 17.0,
                      fontFamily: Constants.pacifico,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
