import 'package:flutter/foundation.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/%08auth_model.dart';
import 'package:mango/viewModel/login/login_shared_prefs.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:mango/model/login/abstract_auth.dart';

// Apple Login viewModel
class AppleAuthService implements AbstractAuth {
  // 애플 로그인
  @override
  Future<AuthInfo?> login() async {
    final LoginSharePrefs _LoginSharePrefs = LoginSharePrefs(); // shared_preferences 뷰모델

    try {
      if (kDebugMode) {
        print("[Apple] 애플 로그인 시도");
      }
      // apple 로그인 시 로그인 정보에 따른 내용
      // 사용자가 "가리기" 요청하면 이메일은 [암호화@appleid.com] 으로 변경 됨
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
            scopes: <AppleIDAuthorizationScopes>[
              AppleIDAuthorizationScopes.email, // 이메일
              AppleIDAuthorizationScopes.fullName, // 이름
            ],
          );      

      if (kDebugMode) {
        print("[Apple] 애플 로그인 성공");
        if  (await _LoginSharePrefs.getEmail('Apple') == 'null') {
          _LoginSharePrefs.saveAuth(AuthPlatform.apple.name, '${credential.email}'); // 애플 platform, email 데이터를 로컬에 저장          
        } 
      }
      
      return AuthInfo(platform: AuthPlatform.apple, email: await _LoginSharePrefs.getEmail('Apple'));
    } catch (error) {
      if (kDebugMode) {
        print("[Apple] 애플 로그인 오류 : ${error.toString()}"); // 에러 내용 출력
      }
      return null;
    }
  }

  @override
  Future<AuthInfo?> logout() async {
    final LoginSharePrefs _LoginSharePrefs = LoginSharePrefs(); // shared_preferences 뷰모델

    print("[Apple] 애플 로그아웃 성공");
    _LoginSharePrefs.removeAuth(); // 로컬 platform, email 삭제

    return null;
  }
}
