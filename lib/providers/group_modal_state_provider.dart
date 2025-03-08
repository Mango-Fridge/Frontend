// 모달 화면 상태 관리
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/group_modal_view_state.dart';

final groupModalStateProvider = StateProvider<GroupModalViewState>((ref) {
  return GroupModalViewState.start; // 초기 값 - 그룹 '시작하기' 뷰
});