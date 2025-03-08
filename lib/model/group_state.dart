// 그룹 - 상태 클래스
class GroupState {
  final String groupName; // 그룹 이름
  final String groupId; // 그룹id
  final String? errorMessage; // 에러메시지
  final bool isButton; // 버튼활성

  GroupState({
    required this.groupName,
    required this.groupId,
    this.errorMessage,
    required this.isButton,
  });

  GroupState copyWith({
    String? groupName,
    String? groupId,
    String? errorMessage,
    bool? isButton,
  }) {
    return GroupState(
      groupName: groupName ?? this.groupName,
      groupId: groupId ?? this.groupId,
      errorMessage: errorMessage,
      isButton: isButton ?? this.isButton,
    );
  }
}