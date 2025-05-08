import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/services/login/login_service.dart';
import 'package:mango/services/login/login_shared_prefs.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:mango/model/login/abstract_auth.dart';

// Apple Login viewModel
class AppleAuthService implements AbstractAuth {
  final LoginService _loginService = LoginService(); // 서버 로그인

  // 애플 로그인
  @override
  Future<AuthInfo?> login() async {
    final LoginSharePrefs _LoginSharePrefs =
        LoginSharePrefs(); // shared_preferences 뷰모델

    try {
      if (kDebugMode) print("[Apple] 애플 로그인 시도");

      String? token = await _LoginSharePrefs.getAppleToken();

      if (token!.isNotEmpty) {
        return await _loginService.postLogin(); // 서버와 로그인 처리
      } else {
        // 애플 로그인 요청
        final AuthorizationCredentialAppleID credential =
            await SignInWithApple.getAppleIDCredential(
              scopes: <AppleIDAuthorizationScopes>[
                AppleIDAuthorizationScopes.email, // 이메일
                AppleIDAuthorizationScopes.fullName, // 이름
              ],
            );

        debugPrint("[Apple] 애플 로그인 성공");
        await _LoginSharePrefs.saveAppleToken(credential.identityToken!);

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
          if (kDebugMode) print("[Apple] 데이터 가져오기");
          // identityToken에서 이메일 추출
          email =
              (await decodeIdentityToken(
                credential.identityToken!.split('.'),
              ))!;
        } else {
          if (kDebugMode) print("[Apple] 이메일 정보를 찾을 수 없음");
        }

        // 이메일 저장
        await _LoginSharePrefs.saveAuth(AuthPlatform.APPLE.name, email);

        return AuthInfo(oauthProvider: AuthPlatform.APPLE, email: email);
      }
    } catch (error) {
      if (error is SignInWithAppleAuthorizationException) {
        if (error.code == AuthorizationErrorCode.canceled) {
          debugPrint("[Apple] 사용자가 로그인을 취소했습니다.");
        }
      } else {
        debugPrint("[Apple] 애플 로그인 오류: $error");
      }
      return null;
    }
  }

  // identityToken에서 데이터 추출 (이메일)
  Future<String?> decodeIdentityToken(List<String> token) async {
    List<String> tokenStr = token;
    if (tokenStr.length < 2) {
      throw Exception("[Apple] 잘못된 identityToken 형식");
    }
    // 0 : header, alg / kid
    // 1 : id Token, JWT
    String payload = base64.normalize(tokenStr[1]);
    final List<int> jsonData = base64.decode(payload);
    final userInfo = jsonDecode(utf8.decode(jsonData));
    if (userInfo.containsKey('email')) {
      if (kDebugMode) print("[Apple] 추출된 이메일: ${userInfo['email']}");
      return userInfo['email'];
    } else {
      throw Exception("[Apple] identityToken에 이메일 정보 없음");
    }
  }

  @override
  Future<AuthInfo?> logout() async {
    final LoginSharePrefs _LoginSharePrefs =
        LoginSharePrefs(); // shared_preferences 뷰모델

    try {
      // 예정 : [애플에서 사용자 정보 제거 하는 로직]
      await _LoginSharePrefs.removeAuth('Apple'); // 로컬 계정 삭제
      if (kDebugMode) print("[Apple] 애플 로그아웃 성공");
    } catch (error) {
      if (kDebugMode) print("[Apple] 로그아웃 실패 $error");
    }

    return null;
  }
}
