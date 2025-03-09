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

  // 참여하기 - GroupId를 통해 냉장고그룹 정보 확인 여부 '더미값'
  final List<Map<String, dynamic>> dummyGroups = <Map<String, dynamic>>[
    {
      "groupId": "g000000001",
      "groupName": "가족냉장고",
      "groupUserKing": "나는김종혁",
      "groupUserCount": 3,
    },
    {
      "groupId": "g000000002",
      "groupName": "자취방냉장고",
      "groupUserKing": "나는박준영",
      "groupUserCount": 2,
    },
    {
      "groupId": "g000000003",
      "groupName": "식당냉장고",
      "groupUserKing": "나는신현우",
      "groupUserCount": 5,
    },
  ];
}
