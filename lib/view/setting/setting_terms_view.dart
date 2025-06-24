import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SettingTermsView extends StatefulWidget {
  const SettingTermsView({super.key});

  @override
  State<SettingTermsView> createState() => _SettingTermsViewState();
}

class _SettingTermsViewState extends State<SettingTermsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 초기화시 기본 탭 URL을 세팅 (예: 첫 탭)
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(dotenv.get('Privacy_Policy')));

    // 탭 변경 시 URL 변경
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return; // 스와이프 중일때 방지

      final url =
          _tabController.index == 0
              ? dotenv.get('Privacy_Policy')
              : dotenv.get('Terms_Of_Service');

      _webViewController.loadRequest(Uri.parse(url));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("약관 및 정책"),
        bottom: TabBar(
          indicatorColor: Colors.orange,
          dividerColor: Colors.white,
          controller: _tabController,
          tabs: const <Widget>[Tab(text: "개인 정보"), Tab(text: "서비스 이용")],
        ),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
