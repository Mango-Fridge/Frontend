// 모달 화면 상태 관리
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/group_enum_state.dart';

final groupModalStateProvider = StateProvider<GroupModalState>((ref) {
  return GroupModalState.start; // 초기 값 - 그룹 '시작하기' 뷰
});

// 초기화면, 생성하기/참여하기 등으로 변하는 화면UI 상태관리
final grouViewStateProvider = StateProvider<GroupViewlState>((ref) {
  return GroupViewlState.start; // 초기 값 - 그룹 '시작하기' 뷰
});
