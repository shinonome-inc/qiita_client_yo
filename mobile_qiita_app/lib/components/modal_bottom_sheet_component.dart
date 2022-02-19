import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/pages/privacy_policy_page.dart';
import 'package:mobile_qiita_app/pages/term_of_service_page.dart';
import 'package:mobile_qiita_app/views/web_view_in_modal_bottom_sheet.dart';

// showModalBottomSheet内で表示するWebViewのコンテンツ
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
  late Widget _contentInModalBottomSheet;

  // ModalBottomSheetで表示するコンテンツを判定
  void _initContentInModalBottomSheet() {
    if (widget.headerTitle == 'プライバシーポリシー') {
      _contentInModalBottomSheet = PrivacyPolicyPage();
    } else if (widget.headerTitle == '利用規約') {
      _contentInModalBottomSheet = TermOfServicePage();
    } else {
      _contentInModalBottomSheet =
          WebViewInModalBottomSheet(initialUrl: widget.webViewUrl);
    }
  }

  @override
  void initState() {
    super.initState();
    _initContentInModalBottomSheet();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.96,
      minChildSize: 0.8,
      initialChildSize: 0.96,
      builder: (context, scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.96,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24.0),
                  ),
                  color: const Color(0xF7F7F7FF),
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
                  child: _contentInModalBottomSheet,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
