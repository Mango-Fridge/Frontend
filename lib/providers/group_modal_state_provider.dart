// 모달 화면 상태 관리
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/group_modal_state.dart';

final groupModalStateProvider = StateProvider<GroupModalState>((ref) {
  return GroupModalState.start; // 초기 값 - 그룹 '시작하기' 뷰
});
