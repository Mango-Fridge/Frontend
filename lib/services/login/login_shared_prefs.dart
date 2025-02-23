import 'package:shared_preferences/shared_preferences.dart';

// shared_preferences를 활용하기 위한 뷰모델
class LoginSharePrefs {
  // 플랫폼과 이메일을 로컬에 저장
  Future<void> saveAuth(String platform, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('platform', platform);
    await prefs.setString('email', email);

    print('[shared_preferences] email: ${prefs.getString('email')}');
    print('[shared_preferences] platform: ${prefs.getString('platform')}');
  }

  // 로컬에 저장된 이메일 가져오기
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // 로컬에 저장된 플랫폼 가져오기
  Future<String?> getPlatform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('platform');
  }

  // 로컬에 저장한 플랫폼과 이메일 제거
  Future<void> removeAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('platform');

    print('[shared_preferences] email: ${prefs.getString('email')}');
    print('[shared_preferences] platform: ${prefs.getString('platform')}');
  }
}