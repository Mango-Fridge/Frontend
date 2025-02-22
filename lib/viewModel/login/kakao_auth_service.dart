import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/user_model.dart';
import 'package:mango/model/login/abstract_auth.dart';
import 'package:mango/viewModel/login/shared_prefs.dart';

// Kakao Login viewModel
class KakaoAuthService implements AbstractAuth {
  final SharedPrefs _sharedPrefs = SharedPrefs(); // shared_preferences 뷰모델

  // 카카오 로그인
  @override
  Future<UserInfo?> login() async {
    // 토큰 존재 여부 확인
    if (await AuthApi.instance.hasToken()) {
      try {
        // 액세스 토큰 정보 확인
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();

        if (kDebugMode) {
          print(
            '[Kakao] 토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}',
          ); // 아이디와 남은 시간(expiresIn)
        }

        // 카카오에서 사용자 정보 가져오기(email)
        User user = await UserApi.instance.me();
        _sharedPrefs.saveEmail('${user.kakaoAccount?.email}'); // 카카오 email 데이터를 로컬에 저장
        print('[shared_preferences] email: ${await _sharedPrefs.getEmail()}');

        return UserInfo(platform: AuthPlatform.kakao ,email: user.kakaoAccount?.email);
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          if (kDebugMode) {
            print('[Kakao] 토큰 만료 $error');
          }
        } else {
          if (kDebugMode) {
            print('[Kakao] 토큰 정보 조회 실패 $error');
          }
        }
      }
    } else {
      if (kDebugMode) {
        print('[Kakao] 발급된 토큰이 없음');
      }
    }

    // 만약, 발급된 토큰이 없을 때
    // 카카오 로그인 시도를 위해 카카오앱이 설치되어 있는지 체크
    if (await isKakaoTalkInstalled()) {
      try {
        if (kDebugMode) {
          print('[Kakao] 카카오톡으로 로그인 시도');
        }
        await UserApi.instance.loginWithKakaoTalk(); // 카카오앱으로 로그인
        User user = await UserApi.instance.me();

        if (kDebugMode) {
          print('[Kakao] 카카오톡으로 로그인 성공');
        }

        _sharedPrefs.saveEmail('${user.kakaoAccount?.email}'); // 카카오 email 데이터를 로컬에 저장
        print('[shared_preferences] email: ${await _sharedPrefs.getEmail()}');

        return UserInfo(platform: AuthPlatform.kakao ,email: user.kakaoAccount?.email);
      } catch (error) {
        if (kDebugMode) {
          print('[Kakao] 카카오톡으로 로그인 실패 $error');
        }

        // 사용자가 로그인을 취소했을경우,
        if (error is PlatformException && error.code == 'CANCELED') {
          if (kDebugMode) {
            print('[Kakao] 사용자가 로그인을 취소했습니다');
          }
          return null;
        }

        // 카카오톡이 설치O, 카카오계정이 없는 경우
        try {
          if (kDebugMode) {
            print('[Kakao] 카카오계정으로 로그인 시도');
          }
          await UserApi.instance.loginWithKakaoAccount(); // 웹사이트에서 로그인
          User user = await UserApi.instance.me();

          if (kDebugMode) {
            print('[Kakao] 카카오톡으로 로그인 성공');
          }

          _sharedPrefs.saveEmail('${user.kakaoAccount?.email}'); // 카카오 email 데이터를 로컬에 저장
          print('[shared_preferences] email: ${await _sharedPrefs.getEmail()}');

          return UserInfo(platform: AuthPlatform.kakao ,email: user.kakaoAccount?.email);
        } catch (error) {
          if (kDebugMode) {
            print('[Kakao] 카카오계정으로 로그인 실패 $error');
          }
        }
      }
      // 카카오톡이 설치X, 카카오계정으로 로그인
    } else {
      try {
        if (kDebugMode) {
          print('[Kakao] 카카오계정으로 로그인 시도');
        }
        await UserApi.instance.loginWithKakaoAccount(); // 웹사이트에서 로그인

        if (kDebugMode) {
          print('[Kakao] 카카오톡으로 로그인 성공');
        }

        User user = await UserApi.instance.me();
        _sharedPrefs.saveEmail('${user.kakaoAccount?.email}'); // 카카오 email 데이터를 로컬에 저장
        print('[shared_preferences] email: ${await _sharedPrefs.getEmail()}');
        
        return UserInfo(platform: AuthPlatform.kakao ,email: user.kakaoAccount?.email);
      } catch (error) {
        if (kDebugMode) {
          print('[Kakao] 카카오계정으로 로그인 실패 $error');
        }
      }
    }
    return null;
  }

  // 카카오 로그아웃
  @override
  Future<UserInfo?> logout() async {
    final SharedPrefs _sharedPrefs = SharedPrefs(); // shared_preferences 뷰모델
    
    try {
      await UserApi.instance.logout(); // 로그아웃
      if (kDebugMode) {
        print("[Kakao] 로그아웃 성공");
        _sharedPrefs.clearEmail(); // 로컬 email 삭제
        print('[shared_preferences] email: ${await _sharedPrefs.getEmail()}');
      }
      return null;
    } catch (error) {
      if (kDebugMode) {
        print("[Kakao] 로그아웃 실패 $error");
      }
    }
    return null;
  }
}
