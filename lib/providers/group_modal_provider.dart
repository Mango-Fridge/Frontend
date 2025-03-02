import 'package:flutter_riverpod/flutter_riverpod.dart';

// 모달 상태 관리를 위한 provider와 notifier
class GroupModalNotifier extends Notifier<bool> {
  @override
  bool build() => false; // 초기 상태: 모달 닫힘

  void showModal() {
    state = true; // 모달 열기
  }

  void hideModal() {
    state = false; // 모달 닫기
  }
}

// 모달 상태 관리 Provider
final groupModalProvider = NotifierProvider<GroupModalNotifier, bool>(GroupModalNotifier.new);
