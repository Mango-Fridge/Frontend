// 그룹 - 상태 클래스: 유효성 검사 및 통신에 사용
import 'package:mango/model/group.dart';

class GroupState {
  final String? groupId; // 그룹id
  final String? groupName; // 그룹 이름
  final String? groupOwner; // 그룹장
  final List<GroupUser>? groupUsers; // 그룹인원
  final String? errorMessage; // 에러메시지
  final bool isButton; // 버튼활성

  GroupState({
    this.groupId,
    this.groupName,
    this.groupOwner,
    this.groupUsers,
    this.errorMessage,
    required this.isButton,
  });

  GroupState copyWith({
    String? groupId,
    String? groupName,
    String? groupOwner,
    List<GroupUser>? groupUsers,
    String? errorMessage,
    bool? isButton,
  }) {
    return GroupState(
      groupId: groupId,
      groupName: groupName,
      groupOwner: groupOwner,
      groupUsers: groupUsers,
      errorMessage: errorMessage,
      isButton: isButton ?? this.isButton,
    );
  }
}