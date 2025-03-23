import 'package:dio/dio.dart';
import 'package:mango/model/group/group.dart';

class GroupRepository {
  // email로 group list 불러오는 함수
  Future<List<Group>> loadGroupList(int email) async {
    // email에 해당하는 group list 불러오는 api 호출
    await Future.delayed(Duration(seconds: 1));

    return <Group>[
      Group(groupId: 000000001, groupName: '본가냉장고', groupCode: "GRP-43-00001", groupOwnerId: 1),
      Group(groupId: 000000002, groupName: '자취방냉장고', groupCode: "GRP-43-00002", groupOwnerId: 2),
      Group(groupId: 000000003, groupName: '식당냉장고', groupCode: "GRP-43-00003", groupOwnerId: 2),
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


  final Dio _dio = Dio();
  String _baseUrl = '';

   // 그룹 생성 API 요청
  Future<Group?> createGroup(int userId, String groupName) async {
    _baseUrl = 'http://localhost:8080/api/groups/create';
    try {
      final response = await _dio.post(
        _baseUrl,
        data: {
          "userId": userId,
          "groupName": groupName
        },
      );

      if (response.statusCode == 200) {
        return Group.fromJson(response.data);
      } else {
        throw Exception('Failed to create group');
      }
    } catch (e) {
      print("Error creating group: $e");
      return null;
    }
  }
}
