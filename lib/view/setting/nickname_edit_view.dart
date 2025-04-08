import 'package:flutter/material.dart';

class NicknameEditView extends StatefulWidget {
  const NicknameEditView({super.key});

  @override
  State<NicknameEditView> createState() => _NicknameEditViewState();
}

class _NicknameEditViewState extends State<NicknameEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("닉네임 변경")));
  }
}
