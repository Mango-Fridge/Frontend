import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:mango/model/user_model.dart';
import 'package:mango/viewModel/login/abstract_auth.dart';

class KakaoAuthService implements AbstractAuth {
  // 카카오톡 로그인
  @override
  Future<UserInfo?> login() async {
    // 토큰이 유효한지
    if (await AuthApi.instance.hasToken()) {
      try {
        // AccessTokenInfo: 현재 저장된 토큰 확인
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}'); // 아이디와 남은 시간(expiresIn)

        // 추후 자동로그인 부분에서 토큰 확인한 후, 정보를 가져오기 위함
        // 사용자 정보 가져오기
        User user = await UserApi.instance.me();
        return UserInfo(
          email: user.kakaoAccount?.email,
        );
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }
      }
    } else {
      print('발급된 토큰이 없음.');
    }

    // 카카오톡 실행 가능 여부 확인 (카카오톡이 설치되어 있는가)
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');

        User user = await UserApi.instance.me();
        return UserInfo(
          email: user.kakaoAccount?.email,
        );
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }

        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');

          User user = await UserApi.instance.me();
          return UserInfo(
            email: user.kakaoAccount?.email,
          );
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      // 카카오톡이 설치X, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');

        User user = await UserApi.instance.me();
        return UserInfo(
          email: user.kakaoAccount?.email,
        );
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  // 카카오톡 로그아웃
  @override
  Future<UserInfo?> logout() async {
    try {
      await UserApi.instance.logout(); // 로그아웃 하겠다는 메서드, 토큰까지 초기화 -> 다시 로그인하려면 새로운 계정 연결 필요
      // await UserApi.instance.logout(); // 다시 로그인하면 같은 계정으로 자동 로그인 가능
      print("로그아웃 성공");
      return null;
    } catch (error) {
      print("로그아웃 실패");
    }
  }
}