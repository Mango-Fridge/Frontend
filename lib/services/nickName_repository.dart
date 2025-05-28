import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mango/model/rest_client.dart';

class NicknameRepository {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10), // 연결 타임아웃
      receiveTimeout: const Duration(seconds: 10), // 응답 타임아웃
    ),
  );

  Future<void> putEditNickName(int userId, String username) async {
    try {
      final RestClient client = RestClient(dio);
      await client.editNickName(userId, username);
    } catch (e) {
      debugPrint("[Server] 닉네임 변경 실패 $e");
      throw Exception(e);
    }
  }
}
