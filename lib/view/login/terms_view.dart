import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mango/design.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 약관 동의 View
class TermsView extends StatefulWidget {
  final VoidCallback onAccept;
  final String termsType;

  const TermsView({super.key, required this.onAccept, required this.termsType});

  @override
  _TermsViewState createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              widget.termsType == 'privacy policy'
                  ? dotenv.get('Privacy_Policy')
                  : dotenv.get('Terms_Of_Service'),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(child: WebViewWidget(controller: _webViewController)),
            const SizedBox(height: 20),
            const Text(
              "필수 약관에 동의하면 서비스 이용이 가능합니다.",
              style: TextStyle(
                color: Colors.orange,
                fontSize: Design.normalFontSize1,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onAccept,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  design.termsAgreeButtonHeight,
                ),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                '동의',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Design.normalFontSize1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
