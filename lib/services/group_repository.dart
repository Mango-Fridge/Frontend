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

  // 그룹id 존재 여부 - 더미값
  final List<Group> dummyGroups = <Group>[
    Group(
      groupId: 'g000000001',
      groupName: '본가냉장고',
      groupOwner: 'qwer1234@gmail.com',
      groupUsers: <GroupUser>[
        GroupUser(email: 'qqq@gmail.com', nickName: '안녕'),
        GroupUser(email: 'qwer1234@gmail.com', nickName: '그룹장입니다'),
        GroupUser(email: 'qwer12341234@gmail.com', nickName: '테스트용')
      ],
    ),
    Group(
      groupId: 'g000000002',
      groupName: '자취방냉장고',
      groupOwner: 'qqq@gmail.com',
      groupUsers: <GroupUser>[
        GroupUser(email: 'qqq@gmail.com', nickName: '그룹장이다'),
        GroupUser(email: 'qwer1234@gmail.com', nickName: '헬로우'),
        GroupUser(email: 'qwer1234@gmail.com', nickName: '테스트용')
      ],
    ),
    Group(
      groupId: 'g000000003',
      groupName: '식당냉장고',
      groupOwner: 'qwer1234@gmail.com',
      groupUsers: <GroupUser>[
        GroupUser(email: 'qqq@gmail.com', nickName: '안녕'),
        GroupUser(email: 'qwer1234@gmail.com', nickName: '나는그룹장'),
        GroupUser(email: 'qw1234@gmail.com', nickName: '테스트용')
      ],
    ),
  ];
}
