import 'package:flutter/foundation.dart';
import 'package:mango/model/login/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:mango/model/login/abstract_auth.dart';

// Apple Login viewModel
class AppleAuthService implements AbstractAuth {
  // 애플 로그인
  @override
  Future<UserInfo?> login() async {
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
      }
      return UserInfo(email: credential.email);
    } catch (error) {
      if (kDebugMode) {
        print("[Apple] 애플 로그인 오류 : ${error.toString()}"); // 에러 내용 출력
      }
      return null;
    }
  }

  @override
  Future<UserInfo?> logout() async {
    return null;
  }
}
