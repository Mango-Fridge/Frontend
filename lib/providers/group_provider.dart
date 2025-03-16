import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/group.dart';
import 'package:mango/services/group_repository.dart';

class GroupNotifier extends Notifier<List<Group>> {
  final _groupRepository = GroupRepository();

  @override
  List<Group> build() => <Group>[];

  Future<void> loadGroupList(int userId) async {
    try {
      final List<Group> groupList = await _groupRepository.loadGroupList(
        userId,
      );
      state = groupList;
    } catch (e) {
      state = <Group>[];
    }
  }
}

final NotifierProvider<GroupNotifier, List<Group>> groupProvider =
    NotifierProvider<GroupNotifier, List<Group>>(GroupNotifier.new);

// email에 의해 불려온 group List 관리
// 그룹에 의해 불려온 content List 관리

// 물품 + 개수 상태 관리
// 물품 - 개수 상태 관리

// 테스트 용도 후에 지울것 - 생성하기, 참가하기 눌렀을 때 bool로 화면 바뀜 (통신에서는 ex. 200, 400)
final groupBoolProvider = StateProvider<bool>((ref) => false);
