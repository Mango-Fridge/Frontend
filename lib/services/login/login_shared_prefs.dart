import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// shared_preferences를 활용하기 위한 뷰모델
class LoginSharePrefs {
  // 플랫폼과 이메일을 로컬에 저장
  Future<void> saveAuth(String platform, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('platform', platform);

    switch (platform) {
      case 'KAKAO':
        await prefs.setString('KakaoEmail', email);
        debugPrint(
          '[shared_preferences] KakaoEmail: ${prefs.getString('KakaoEmail')}',
        );
        debugPrint(
          '[shared_preferences] platform: ${prefs.getString('platform')}',
        );
        break;
      case 'APPLE':
        await prefs.setString('AppleEmail', email);
        debugPrint(
          '[shared_preferences] AppleEmail: ${prefs.getString('AppleEmail')}',
        );
        debugPrint(
          '[shared_preferences] platform: ${prefs.getString('platform')}',
        );
        break;
    }
  }

  // (appleLogin 한정) 로컬에 token을 저장하기 위한 용도
  Future<void> saveAppleToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('AppleToken', token);
    debugPrint(
      '[shared_preferences] AppleToken: ${prefs.getString('AppleToken')}',
    );
  }

  // (appleLogin 한정) 로컬에 저장된 토큰 가져오기
  Future<String?> getAppleToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('AppleToken') ?? "";
  }

  // 로컬에 저장된 이메일 가져오기
  Future<String?> getEmail(String platform) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (platform) {
      case 'KAKAO':
        return prefs.getString('KakaoEmail');
      case 'APPLE':
        return prefs.getString('AppleEmail');
    }

    return null;
  }

  // 로컬에 저장된 플랫폼 가져오기
  Future<String?> getPlatform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('platform');
  }

  // 로컬에 저장한 플랫폼/이메일 제거
  Future<void> removeAuth(String platform) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // (appleLogin 한정) 로컬에 저장된 토큰 제거
    switch (platform) {
      case 'Apple':
        await prefs.remove('AppleToken');
    }

    await prefs.remove('${platform}Email');
    await prefs.remove(platform);
  }
}
