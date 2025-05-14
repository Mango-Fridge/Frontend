import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/model/login/abstract_auth.dart';
import 'package:mango/model/rest_client.dart';
import 'package:mango/services/login/login_service.dart';
import 'package:mango/services/login/login_shared_prefs.dart';
import 'package:mango/toastMessage.dart';

// Kakao Login viewModel
class KakaoAuthService implements AbstractAuth {
  final LoginSharePrefs _LoginSharePrefs =
      LoginSharePrefs(); // shared_preferences 뷰모델
  final LoginService _loginService = LoginService(); // 서버 로그인

  // 카카오 로그인
  @override
  Future<AuthInfo?> login() async {
    // 토큰 존재 여부 확인
    if (await AuthApi.instance.hasToken()) {
      try {
        // 액세스 토큰 정보 확인
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();

        if (kDebugMode) {
          debugPrint(
            '[Kakao] 토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}',
          ); // 아이디와 남은 시간(expiresIn)
        }

        // 카카오에서 사용자 정보 가져오기(email)
        User user = await UserApi.instance.me();
        _LoginSharePrefs.saveAuth(
          AuthPlatform.KAKAO.name,
          '${user.kakaoAccount?.email}',
        ); // 카카오 platform, email 데이터를 로컬에 저장

        return await _loginService.postLogin(); // 서버와 로그인 처리
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          if (kDebugMode) {
            debugPrint('[Kakao] 토큰 만료 $error');
          }
        } else if (error is DioException) {
          // 서버와 통신이 되지 않으면,
          return null;
        } else {
          if (kDebugMode) {
            debugPrint('[Kakao] 토큰 정보 조회 실패 $error');
          }
        }
      }
    } else {
      if (kDebugMode) {
        debugPrint('[Kakao] 발급된 토큰이 없음');
      }
    }

    // 만약, 발급된 토큰이 없을 때
    // 카카오 로그인 시도를 위해 카카오앱이 설치되어 있는지 체크
    if (await isKakaoTalkInstalled()) {
      try {
        if (kDebugMode) {
          debugPrint('[Kakao] 카카오톡으로 로그인 시도');
        }
        await UserApi.instance.loginWithKakaoTalk(); // 카카오앱으로 로그인

        if (kDebugMode) {
          debugPrint('[Kakao] 카카오톡으로 로그인 성공');
        }

        User user = await UserApi.instance.me();
        _LoginSharePrefs.saveAuth(
          AuthPlatform.KAKAO.name,
          '${user.kakaoAccount?.email}',
        ); // 카카오 platform, email 데이터를 로컬에 저장

        return await _loginService.postLogin(); // 서버와 로그인 처리
      } catch (error) {
        if (error is DioException) {
          // 서버와 통신이 되지 않으면,
          return null;
        } else {
          debugPrint('[Kakao] 카카오톡으로 로그인 실패 $error');
        }

        // 사용자가 로그인을 취소했을경우,
        if (error is PlatformException && error.code == 'CANCELED') {
          if (kDebugMode) {
            debugPrint('[Kakao] 사용자가 로그인을 취소했습니다');
          }
          return null;
        }

        // 카카오톡이 설치O, 카카오계정이 없는 경우
        try {
          if (kDebugMode) {
            debugPrint('[Kakao] 카카오계정으로 로그인 시도');
          }
          await UserApi.instance.loginWithKakaoAccount(); // 웹사이트에서 로그인

          if (kDebugMode) {
            debugPrint('[Kakao] 카카오톡으로 로그인 성공');
          }

          User user = await UserApi.instance.me();
          _LoginSharePrefs.saveAuth(
            AuthPlatform.KAKAO.name,
            '${user.kakaoAccount?.email}',
          ); // 카카오 platform, email 데이터를 로컬에 저장

          return await _loginService.postLogin(); // 서버와 로그인 처리
        } catch (error) {
          if (error is DioException) {
            // 서버와 통신이 되지 않으면,
            return null;
          } else {
            debugPrint('[Kakao] 카카오톡으로 로그인 실패 $error');
          }
        }
      }
      // 카카오톡이 설치X, 카카오계정으로 로그인
    } else {
      try {
        if (kDebugMode) {
          debugPrint('[Kakao] 카카오계정으로 로그인 시도');
        }
        await UserApi.instance.loginWithKakaoAccount(); // 웹사이트에서 로그인

        if (kDebugMode) {
          debugPrint('[Kakao] 카카오톡으로 로그인 성공');
        }

        User user = await UserApi.instance.me();
        _LoginSharePrefs.saveAuth(
          AuthPlatform.KAKAO.name,
          '${user.kakaoAccount?.email}',
        ); // 카카오 platform, email 데이터를 로컬에 저장

        return await _loginService.postLogin(); // 서버와 로그인 처리
      } catch (error) {
        if (error is DioException) {
          // 서버와 통신이 되지 않으면,
          return const AuthInfo(); // 일부러 값을 null로 던짐
        } else {
          debugPrint('[Kakao] 카카오톡으로 로그인 실패 $error');
        }
      }
    }
    return null;
  }

  // 카카오 로그아웃
  @override
  Future<AuthInfo?> logout() async {
    final LoginSharePrefs _LoginSharePrefs =
        LoginSharePrefs(); // shared_preferences 뷰모델

    try {
      await UserApi.instance.logout(); // 카카오 로그아웃
      await _LoginSharePrefs.removeAuth('Kakao'); // 로컬 계정 삭제
      if (kDebugMode) print("[Kakao] 로그아웃 성공");
      return null;
    } catch (error) {
      if (kDebugMode) print("[Kakao] 로그아웃 실패 $error");
    }
    return null;
  }
}
