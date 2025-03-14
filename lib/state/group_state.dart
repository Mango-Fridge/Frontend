// 그룹 - 상태 클래스: 유효성 검사 및 통신에 사용
class GroupState {
  final String? groupId; // 그룹id
  final String? groupName; // 그룹 이름
  final String? gruoupUserKing; // 그룹장
  final int? groupUserCount; // 그룹 인원수
  final String? errorMessage; // 에러메시지
  final bool isButton; // 버튼활성
  final bool isLoadingButton; // 작업 중, 버튼 로딩

  GroupState({
    this.groupId,
    this.groupName,
    this.gruoupUserKing,
    this.groupUserCount,
    this.errorMessage,
    required this.isButton,
    required this.isLoadingButton,
  });

  GroupState copyWith({
    String? groupId,
    String? groupName,
    String? gruoupUserKing,
    int? groupUserCount,
    String? errorMessage,
    bool? isButton,
    bool? isLoadingButton,
  }) {
    return GroupState(
      groupId: groupId,
      groupName: groupName,
      gruoupUserKing: gruoupUserKing,
      groupUserCount: groupUserCount,
      errorMessage: errorMessage,
      isButton: isButton ?? this.isButton,
      isLoadingButton: isLoadingButton ?? this.isLoadingButton,
    );
  }
}