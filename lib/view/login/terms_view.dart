import 'package:flutter/material.dart';
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
                  ? 'https://www.naver.com'
                  : 'https://google.com',
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
            ElevatedButton(
              onPressed: widget.onAccept,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  design.termsAgreeButtonHeight,
                ),
                backgroundColor: Colors.amber[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('동의', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
