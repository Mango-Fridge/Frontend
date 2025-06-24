// 그룹 - 상태 클래스: 유효성 검사 및 통신에 사용
class GroupState {
  final int? groupId; // 그룹id
  final String? groupCode; // 그룹 코드
  final String? groupName; // 그룹 이름
  final String? groupOwnerName; // 그룹장
  final int? groupMemberCount; // 그룹 인원수
  final String? errorMessage; // 에러메시지
  final bool isButton; // 버튼활성
  final bool isLoadingButton; // 작업 중, 버튼 로딩

  GroupState({
    this.groupId,
    this.groupCode,
    this.groupName,
    this.groupOwnerName,
    this.groupMemberCount,
    this.errorMessage,
    this.isButton = false,
    this.isLoadingButton = false,
  });

  GroupState copyWith({
    int? groupId,
    String? groupCode,
    String? groupName,
    String? groupOwnerName,
    int? groupMemberCount,
    String? errorMessage,
    bool? isButton,
    bool? isLoadingButton,
  }) {
    return GroupState(
      groupId: groupId,
      groupCode: groupCode,
      groupName: groupName,
      groupOwnerName: groupOwnerName,
      groupMemberCount: groupMemberCount,
      errorMessage: errorMessage,
      isButton: isButton ?? this.isButton,
      isLoadingButton: isLoadingButton ?? this.isLoadingButton,
    );
  }
}