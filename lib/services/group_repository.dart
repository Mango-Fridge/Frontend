import 'package:dio/dio.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/rest_client.dart';

class GroupRepository {
  // email로 group 불러오는 함수
  Future<Group> loadGroup(int userId) async {
    // email에 해당하는 group list 불러오는 api 호출
    await Future.delayed(Duration(seconds: 1));

    return const Group(
      groupId: 000000001,
      groupName: '본가냉장고',
      groupCode: "GRP-43-00001",
      groupOwnerId: 1,
    );
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

  final Dio dio = Dio();

  // 그룹 생성 API 요청
  Future<Group?> createGroup(int userId, String groupName) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "userId": userId,
      "groupName": groupName,
    };

    try {
      ApiResponse response = await client.postCreateGroup(body);

      if (response.code == 200) {
        return Group.fromJson(response.data);
      } else {
        throw Exception('그룹 생성 실패');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;

        // 'error' 안에 'message'가 있을 경우
        if (errorData is Map<String, dynamic> &&
            errorData.containsKey("error") &&
            errorData["error"] is Map<String, dynamic> &&
            errorData["error"].containsKey("message")) {
          throw Exception('${errorData["error"]["message"]}');
        } else {
          throw Exception('서버 응답 오류: ${e.response!.statusCode}');
        }
      } else {
        throw Exception('네트워크 오류 발생: ${e.message}');
      }
    }
  }
}
