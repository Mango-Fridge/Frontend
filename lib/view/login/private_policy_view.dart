import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 개인정보 수집이랑 이용약관 뷰 재사용이 가능할지도..?
class PrivatePolicyView extends StatefulWidget {
  const PrivatePolicyView({super.key});

  @override
  _PrivatePolicyViewState createState() => _PrivatePolicyViewState();
}

class _PrivatePolicyViewState extends State<PrivatePolicyView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse('https://www.naver.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('개인정보 수집 이용 동의')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(child: WebViewWidget(controller: _webViewController)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text('동의')),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}