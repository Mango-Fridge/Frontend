import 'package:mango/model/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// apple 로그인 인증 관련 Service이자 ViewModel
class AppleAuthService {
  Future<UserInfo?> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID
      credential = // apple 로그인 시 로그인 정보에 따른 내용
          await SignInWithApple.getAppleIDCredential(
        scopes: <AppleIDAuthorizationScopes>[
          AppleIDAuthorizationScopes.email, // 암호화 된 이메일
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String? identityToken =
          credential.identityToken; // JWT형식으로 반환 된다고 한다.
      final String? authorizationCode =
          credential.authorizationCode; // 임시 인증 코드 인듯.

      return UserInfo(
        email: credential.email,
      );
    } catch (e) {
      /*
      return null;

      return User(
      userId: '',
        email: '',
        fullName: null,
      )

      에러 발생 시 요청 사항에 맞도록 null을 리턴하거나 빈 User를 리턴 하면 될 듯.

      */
      print(e.toString()); // 에러 내용 출력 후
      return null; // 원하는 리턴 값
    }
  }
}
