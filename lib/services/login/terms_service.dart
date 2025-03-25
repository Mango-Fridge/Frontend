import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/model/rest_client.dart';

class TermsService {
  Dio dio = Dio();

  Future<void> updateTerms(AuthInfo authInfo) async {
    RestClient client = RestClient(dio);
    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "usrId": authInfo.usrId,
      "agreePrivacyPolicy": authInfo.agreePrivacyPolicy,
      "agreeTermsOfService": authInfo.agreeTermsOfService,
    };

    try {
      client.updateTerms(body);
    } catch (e) {
      debugPrint("오류 발생: $e");
    }
  }
}
