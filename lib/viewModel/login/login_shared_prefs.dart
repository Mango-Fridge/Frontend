import 'package:shared_preferences/shared_preferences.dart';

// shared_preferences를 활용하기 위한 뷰모델
class LoginSharePrefs {
  // 플랫폼과 이메일을 로컬에 저장
  Future<void> saveAuth(String platform, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('platform', platform);

    switch (platform) {
      case 'Kakao':
        await prefs.setString('kakaoEmail', email);
        print('[shared_preferences] KakaoEmail: ${prefs.getString('kakaoEmail')}');
        print('[shared_preferences] platform: ${prefs.getString('platform')}');
        break;
      case 'Apple':
        await prefs.setString('appleEmail', email);
        print('[shared_preferences] AppleEmail: ${prefs.getString('appleEmail')}');
        print('[shared_preferences] platform: ${prefs.getString('platform')}');
        break;
    }
  }

  // 로컬에 저장된 이메일 가져오기
  Future<String?> getEmail(String platform) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (platform) {
      case 'Kakao':
        return prefs.getString('kakaoEmail');
      case 'Apple':
        return prefs.getString('appleEmail');
    }
    
    return null;
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
  }
}
