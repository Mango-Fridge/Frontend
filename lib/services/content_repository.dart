import 'package:dio/dio.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/rest_client.dart';

class ContentRepository {
  final Dio dio = Dio();

  // content 저장 함수
  Future<void> saveContent(Content content) async {
    await Future.delayed(Duration(seconds: 1));
  }

  // groupId로 content list 불러오는 함수
  Future<List<Content>> loadContentList(int groupId) async {
    RestClient client = RestClient(dio);
    try {
      ApiResponse response = await client.getContentList(groupId);

      if (response.code == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Content.fromJson(item)).toList();
      } else {
        throw Exception('Json 변환 과정 오류');
      }
    } catch (e) {
      throw Exception('loadContentList 오류: $e');
    }
  }
}
