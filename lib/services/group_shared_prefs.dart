import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupSharedPrefs {
  // 그룹 정보 저장
  Future<void> saveJoinedGroup(int groupId, String groupName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('joinedGroupId', groupId);
    await prefs.setString('joinedGroupName', groupName);

    debugPrint('[shared_preferences] joinedGroupId: $groupId');
    debugPrint('[shared_preferences] joinedGroupName: $groupName');
  }

  // 그룹 ID 가져오기
  Future<int?> getJoinedGroupId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('joinedGroupId');
  }

  // 그룹 이름 가져오기
  Future<String?> getJoinedGroupName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('joinedGroupName');
  }

  // 그룹 정보 삭제
  Future<void> removeJoinedGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('joinedGroupId');
    await prefs.remove('joinedGroupName');

    debugPrint('[shared_preferences] joined group data removed');
  }
}