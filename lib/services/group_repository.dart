import 'package:dio/dio.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/rest_client.dart';
import 'package:mango/state/group_state.dart';

class GroupRepository {
  final Dio dio = Dio();

  // userId로 group id, name 불러오기
  Future<Group> loadGroup(int userId) async {
    RestClient client = RestClient(dio);

    try {
      ApiResponse response = await client.getGroupInfo(userId);

      // 통신이 성공하고, 데이터 값이 비어있지 않을 경우
      if (response.code == 200 && response.data != null) {
        final groupInfo = response.data;
        print('그룹 정보: ${groupInfo}');

        return Group(
          groupId: groupInfo['groupId'],
          groupName: groupInfo['groupName'],
        );
      } else {
        throw Exception('그룹 정보를 불러오는 데 실패했습니다.');
      }
    } on DioException catch (e) {
      throw Exception('네트워크 오류 발생: ${e.message}');
    }
  }

  // 그룹 생성 API 요청
  Future<void> createGroup(int userId, String groupName) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "userId": userId,
      "groupName": groupName,
    };

    try {
      ApiResponse response = await client.postCreateGroup(body);

      if (response.code == 200) {
        AppLogger.logger.i("[group_repository/createGroup]: 그룹 생성 완료.");
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

  // 해당 그룹 인원 불러오기
  Future<Group> groupUserList(int userId, int groupId) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "userId": userId,
      "groupId": groupId,
    };

    try {
      ApiResponse response = await client.postGroupUserList(body);
      
      if (response.code == 200) {
        AppLogger.logger.i("[group_repository/groupUserList]: ${Group.fromJson(response.data)}");
        return Group.fromJson(response.data);
      } else {
        throw Exception('그룹 인원 불러오기 실패');
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

  // groupCode로 그룹 존재 여부 확인(유효성)
  Future<GroupState> isGroupValid(String groupCode) async {
    RestClient client = RestClient(dio);

    try {
      ApiResponse response = await client.isGroupValid(groupCode);

      // 통신이 성공하고, 데이터 값이 비어있지 않을 경우
      if (response.code == 200 && response.data != null) {
        final groupInfo = response.data;
        AppLogger.logger.i("[group_repository/isGroupValid]: $groupInfo");

        return GroupState(
          groupName: groupInfo['groupName'],
          groupOwnerName: groupInfo['groupOwnerName'],
          groupMemberCount: groupInfo['groupMemberCount'],
        );
      } else {
        throw Exception('그룹 정보를 불러오는 데 실패했습니다.');
      }
    } on DioException catch (e) {
      throw Exception('네트워크 오류 발생: ${e.message}');
    }
  }

  // 해당 그룹 나가기
  Future<void> exitCurrentGroup(int userId, int groupId) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "userId": userId,
      "groupId": groupId,
    };

    try {
      ApiResponse response = await client.exitGroup(body);

      if (response.code == 200) {
        AppLogger.logger.i("[group_repository/exitCurrentGroup]: 그룹 나가기 성공");
      } else {
        throw Exception('[group_repository/exitCurrentGroup]: Json Parse Error');
      }
    } catch (e) {
      throw Exception('[group_repository/exitCurrentGroup]: ${e}');
    }
  }

  // 그룹 참여하기
  Future<void> postGroupJoin(int userId, int groupId) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "userId": userId,
      "groupId": groupId,
    };

    try {
      ApiResponse response = await client.postGroupJoin(body);

      if (response.code == 200) {
        AppLogger.logger.i("[group_repository/createGroup]: 그룹 참여 완료.");
      } else {
        throw Exception('그룹 참여 실패');
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

  // 그룹 참여 승인 요청 - 거절
  Future<void> putGroupReject(int userId, int groupId) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "userId": userId,
      "groupId": groupId,
    };

    try {
      ApiResponse response = await client.putGroupReject(body);

      if (response.code == 200) {
        AppLogger.logger.i("[group_repository/putGroupReject]: 그룹 참여 승인 요청을 거절");
      } else {
        throw Exception('[group_repository/putGroupReject]: Json Parse Error');
      }
    } catch (e) {
      throw Exception('[group_repository/putGroupReject]: ${e}');
    }
  }

  // 그룹 참여 승인 요청 - 승인
  Future<void> postGroupApprove(int userId, int groupId) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "userId": userId,
      "groupId": groupId,
    };

    try {
      ApiResponse response = await client.postGroupApprove(body);

      if (response.code == 200) {
        AppLogger.logger.i("[group_repository/postGroupApprove]: 그룹 참여 승인 요청을 승인");
      } else {
        throw Exception('[group_repository/postGroupApprove]: Json Parse Error');
      }
    } catch (e) {
      throw Exception('[group_repository/postGroupApprove]: ${e}');
    }
  }
}
