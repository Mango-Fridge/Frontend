import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';

var dio = Dio();
String? userData;

Future<void> postUserData() async {
  OAuthToken? token = await TokenManagerProvider.instance.manager.getToken();
  print(token?.accessToken);

  try {
    final response = await dio.post(
      'http://localhost:8080/user/login',
      data: {"oauthProvider": "Kakao"},
      options: Options(
        headers: {"Authorization": "Bearer ${token?.accessToken}"},
      ),
    );
    userData = response.data.toString(); // JSON 데이터를 문자열로 변환
    print(userData);
  } catch (e) {
    print("데이터를 불러오지 못했습니다: $e");
  }
}
