import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/services/login/login_shared_prefs.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:mango/model/login/abstract_auth.dart';

// Apple Login viewModel
class AppleAuthService implements AbstractAuth {
  // 애플 로그인
  @override
  Future<AuthInfo?> login() async {
    final LoginSharePrefs _LoginSharePrefs =
        LoginSharePrefs(); // shared_preferences 뷰모델

    try {
      if (kDebugMode) print("[Apple] 애플 로그인 시도");

      // 애플 로그인 요청
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
            scopes: <AppleIDAuthorizationScopes>[
              AppleIDAuthorizationScopes.email, // 이메일
              AppleIDAuthorizationScopes.fullName, // 이름
            ],
          );

      if (kDebugMode) print("[Apple] 애플 로그인 성공");

      // 로컬 저장소에서 이메일 가져오기
      String? shareEmail = await _LoginSharePrefs.getEmail('Apple');

      // 이메일 저장 변수
      String email = '';

      if (shareEmail?.isNotEmpty ?? false) {
        // 로컬 저장소에 이메일이 있다면 사용
        email = shareEmail!;
      } else if (credential.email?.isNotEmpty ?? false) {
        // 애플 로그인에서 제공된 이메일 사용 (최초 로그인 시)
        email = credential.email!;
      } else if (credential.identityToken != null) {
        // identityToken에서 이메일 추출
        if (kDebugMode) print("[Apple] 데이터 가져오기");

        List<String> tokenStr = credential.identityToken!.split('.');
        if (tokenStr.length < 2) {
          throw Exception("[Apple] 잘못된 identityToken 형식");
        }
        print("$tokenStr");
        String payload = base64.normalize(tokenStr[1]);
        final List<int> jsonData = base64.decode(payload);
        final userInfo = jsonDecode(utf8.decode(jsonData));
        print("내용 $userInfo");
        if (userInfo.containsKey('email')) {
          email = userInfo['email'];
          if (kDebugMode) print("[Apple] 추출된 이메일: $email");
        } else {
          throw Exception("[Apple] identityToken에 이메일 정보 없음");
        }
      } else {
        if (kDebugMode) print("[Apple] 이메일 정보를 찾을 수 없음");
      }

      // 이메일 저장
      await _LoginSharePrefs.saveAuth(AuthPlatform.apple.name, email);

      return AuthInfo(platform: AuthPlatform.apple, email: email);
    } catch (error) {
      if (kDebugMode) print("[Apple] 애플 로그인 오류: $error");
      return null;
    }
  }

  @override
  Future<AuthInfo?> logout() async {
    final LoginSharePrefs _LoginSharePrefs =
        LoginSharePrefs(); // shared_preferences 뷰모델

    if (kDebugMode) print("[Apple] 애플 로그아웃 성공");
    _LoginSharePrefs.removeAuth(); // 로컬 platform, email 삭제

    return null;
  }
}
