import 'package:dio/dio.dart';
import 'package:mango/model/content.dart';

class ContentRepository {
  final Dio _dio = Dio();
  String _baseUrl = '';

  // content 저장 함수
  Future<void> saveContent(Content content) async {
    await Future.delayed(Duration(seconds: 1));
  }

  // groupId로 content list 불러오는 함수
  Future<List<Content>> loadContentList(int groupId) async {
    _baseUrl = 'http://127.0.0.1:8080/api/contents/group/$groupId';
    try {
      _dio.interceptors.add(LogInterceptor(responseBody: true));
      final response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((item) => Content.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load content');
      }
    } catch (e) {
      throw Exception('Failed to load content: $e');
    }
  }
}
