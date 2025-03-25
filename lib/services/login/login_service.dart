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
      // 애플 로그인 로직 처리
    }

    final tokens = "Bearer $snsToken"; // Authorization 헤더 값
    final body = {"oauthProvider": "$platformStr"}; // 요청 바디
    final resp = await client.getAuthUser(tokens, body);
    debugPrint("사용자 정보 : ${resp.data}");

    return AuthInfo.fromJson(resp.data);
  }
}
