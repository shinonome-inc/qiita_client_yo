import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/texts.dart';
import 'package:mobile_qiita_app/components/app_info_component.dart';
import 'package:mobile_qiita_app/components/web_view_component.dart';

// スクロール可能なModalBottomSheet
class ModalBottomSheetComponent extends StatefulWidget {
  const ModalBottomSheetComponent({
    required this.headerTitle,
    required this.webViewUrl,
    Key? key,
  }) : super(key: key);

  final String headerTitle;
  final String webViewUrl;

  @override
  _ModalBottomSheetComponentState createState() =>
      _ModalBottomSheetComponentState();
}

class _ModalBottomSheetComponentState extends State<ModalBottomSheetComponent> {
  late Widget _modalBottomSheetContent;

  void _initModalBottomSheetContent() {
    if (widget.headerTitle == 'プライバシーポリシー') {
      _modalBottomSheetContent =
          AppInfoComponent(text: Texts.privacyPolicyText);
    } else if (widget.headerTitle == '利用規約') {
      _modalBottomSheetContent =
          AppInfoComponent(text: Texts.termOfServiceText);
    } else {
      _modalBottomSheetContent =
          WebViewComponent(initialUrl: widget.webViewUrl);
    }
  }

  @override
  void initState() {
    super.initState();
    _initModalBottomSheetContent();
  }

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
                    widget.headerTitle,
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
                  child: _modalBottomSheetContent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
