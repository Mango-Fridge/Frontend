import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContentView extends ConsumerStatefulWidget {
  const AddContentView({super.key});
  @override
  ConsumerState<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends ConsumerState<AddContentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("물품 추가 상세 입력"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
