import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_modal_provider.dart';

// 모달 예제 뷰
class ModalContentExample extends ConsumerWidget {
  const ModalContentExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isModalOpen = ref.watch(groupModalProvider);

    double screenHeight = MediaQuery.of(context).size.height;
    double height = isModalOpen ? screenHeight - 500 : screenHeight;

    return AnimatedContainer(
      transform: Matrix4.translationValues(0, height, 0),
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
      child: Container(
        height: 500,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          color: Colors.white,
        ),
        child: const Center(
          child: Text(
            'Bottom Modal Sheet',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}