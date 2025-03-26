import 'package:dio/dio.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/model/rest_client.dart';

class ContentRepository {
  final Dio dio = Dio();

  // item 및 content 저장 함수
  Future<void> saveContent(RefrigeratorItem item) async {
    RestClient client = RestClient(dio);
    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "groupId": item.itemId,
      "itemName": item.itemName,
      "category": item.category,
      "subCategory": item.subCategory,
      "brandName": item.brandName,
      "count": item.count,
      "regDate": item.regDate?.toIso8601String(),
      "expDate": item.expDate?.toIso8601String(),
      "storageArea": item.storageArea,
      "memo": item.memo,
      "nutriUnit": item.nutriUnit,
      "nutriCapacity": item.nutriCapacity,
      "nutriKcal": item.nutriKcal,
      "nutriCarbohydrate": item.nutriCarbohydrate,
      "nutriProtein": item.nutriProtein,
      "nutriFat": item.nutriFat,
      "openItem": item.openItem,
    };

    try {
      client.addItem(body);
    } catch (e) {
      throw Exception("content_repository/saveContent Error: $e");
    }
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

  Future<Content> loadContent(int contentId) async {
    RestClient client = RestClient(dio);
    try {
      ApiResponse response = await client.getContent(contentId);

      if (response.code == 200) {
        Map<String, dynamic> data = response.data;
        return Content.fromJson(data);
      } else {
        throw Exception('Json 변환 과정 오류');
      }
    } catch (e) {
      throw Exception('loadContent 오류: $e');
    }
  }
}
