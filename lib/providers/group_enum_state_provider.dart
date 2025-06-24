// 모달 화면 상태 관리
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/group_enum_state.dart';

final groupModalStateProvider = StateProvider<GroupModalState>((ref) {
  return GroupModalState.create; // 초기 값
});

// 초기화면, 생성하기/참여하기 등으로 변하는 화면UI 상태관리
final grouViewStateProvider = StateProvider<GroupViewState>((ref) {
  return GroupViewState.empty; // 초기 값 - 그룹이 없기에, 초기 그룹 뷰
});
