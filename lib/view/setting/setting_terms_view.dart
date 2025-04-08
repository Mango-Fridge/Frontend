import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingTermsView extends StatefulWidget {
  const SettingTermsView({super.key});

  @override
  State<SettingTermsView> createState() => _SettingTermsViewState();
}

class _SettingTermsViewState extends State<SettingTermsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("약관 및 정책")));
  }
}
