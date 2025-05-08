import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/model/rest_client.dart';
import 'package:mango/services/login/login_shared_prefs.dart';

// 서버와 로그인
class LoginService {
  Dio dio = Dio();

  Future<AuthInfo> postLogin() async {
    final LoginSharePrefs _loginSharePrefs = LoginSharePrefs();
    RestClient client = RestClient(dio);
    String? snsToken;

    final String? platformStr =
        await _loginSharePrefs.getPlatform(); // 로컬에 저장된 platform 가져오기

    if (platformStr == "KAKAO") {
      OAuthToken? token =
          await TokenManagerProvider.instance.manager.getToken();

      snsToken = token!.accessToken;
    } else if (platformStr == "APPLE") {
      snsToken = await _loginSharePrefs.getAppleToken();
    }

    final tokens = "Bearer $snsToken"; // Authorization 헤더 값
    final body = {"oauthProvider": "$platformStr"}; // 요청 바디
    final resp = await client.getAuthUser(tokens, body);
    debugPrint("사용자 정보 : ${resp.data}");

    /// 2025.05.08 애플 로그인을 시도했을때, 토큰이 만료되어 인증에 실패했을때
    /// 로컬데이터에서 삭제시키고 다시 재인증을 밟는 절차를 작성해야함.

    return AuthInfo.fromJson(resp.data);
  }
}
