import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(child: WebViewWidget(controller: _webViewController)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {},
                child: ElevatedButton(
                  onPressed: widget.onAccept,
                  child: const Text('동의'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
