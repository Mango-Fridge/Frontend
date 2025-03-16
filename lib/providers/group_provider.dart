import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/group.dart';
import 'package:mango/services/group_repository.dart';

class GroupNotifier extends Notifier<List<Group>> {
  final _groupRepository = GroupRepository();

  @override
  List<Group> build() => <Group>[];

  Future<void> loadGroupList(String email) async {
    try {
      final List<Group> groupList = await _groupRepository.loadGroupList(email);
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
  