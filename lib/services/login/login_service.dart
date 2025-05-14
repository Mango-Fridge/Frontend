import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/model/rest_client.dart';
import 'package:mango/services/login/login_shared_prefs.dart';

// 서버와 로그인
class LoginService {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10), // 연결 타임아웃
      receiveTimeout: const Duration(seconds: 10), // 응답 타임아웃
    ),
  );

  Future<AuthInfo?> postLogin() async {
    final LoginSharePrefs _loginSharePrefs = LoginSharePrefs();
    final RestClient client = RestClient(dio);

    try {
      // 플랫폼 확인 및 토큰 추출
      final String? platformStr = await _loginSharePrefs.getPlatform();
      String? snsToken;

      if (platformStr == "Kakao") {
        final OAuthToken? token =
            await TokenManagerProvider.instance.manager.getToken();
        snsToken = token?.accessToken;
      } else if (platformStr == "Apple") {
        snsToken = await _loginSharePrefs.getAppleToken();
      }

      if (snsToken == null) {
        debugPrint("SNS 토큰이 존재하지 않습니다.");
        return null;
      }

      // 서버 요청
      final tokens = "Bearer $snsToken";
      final body = {"oauthProvider": "$platformStr"}; // 요청 바디
      final resp = await client.getAuthUser(tokens, body);
      debugPrint("사용자 정보 : ${resp.data}");

      return AuthInfo.fromJson(resp.data);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      debugPrint("로그인 실패 - 상태코드: $statusCode, 에러: ${e.message}");

      // 타임아웃 처리
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        debugPrint("⚠️ 서버 응답 시간 초과. 네트워크 상태를 확인해주세요.");
      }
      // 인증 실패: 400
      else if (statusCode == 400) {
        debugPrint("⚠️ 인증 실패 - 토큰 삭제 및 재인증 필요");

        final String? platformStr = await _loginSharePrefs.getPlatform();

        /// Apple은 별도로 토큰 인증 처리 기능이 없어서 구현
        /// Kakao는 access, refresh 모두가 만료되었을때 기반으로 구현
        await _loginSharePrefs.removeAuth(platformStr!); // 로컬 계정 삭제
      }
      // 기타 서버 오류
      else if (e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError) {
        debugPrint("⚠️ 서버에 연결할 수 없습니다. 인터넷 상태를 확인해주세요.");
      }

      return null;
    } catch (e) {
      debugPrint("알 수 없는 오류 발생: $e");
      return null;
    }
  }
}
