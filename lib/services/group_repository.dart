import 'package:mango/model/group.dart';

class GroupRepository {
  // email로 group list 불러오는 함수
  Future<List<Group>> loadGroupList(String email) async {
    // email에 해당하는 group list 불러오는 api 호출
    await Future.delayed(Duration(seconds: 1));

    return <Group>[
      Group(groupId: 'g000000001', groupName: '본가냉장고', groupOwner: ''),
      Group(groupId: 'g000000002', groupName: '자취방냉장고', groupOwner: ''),
      Group(groupId: 'g000000003', groupName: '식당냉장고', groupOwner: ''),
    ];
  }
}
