import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/model/rest_client.dart';

class ItemRepository {
  final Dio dio = Dio();

  // 검색어를 받아오면 해당 검색어에 해당하는 결과 리스트 받아오는 api 함수
  Future<List<RefrigeratorItem>> loadItemListByString(
    String keyword,
    int page,
  ) async {
    RestClient client = RestClient(dio);

    try {
      await Future.delayed(const Duration(seconds: 1));

      ApiResponse response = await client.getItemList(keyword, page);

      if (response.code == 200) {
        AppLogger.logger.d(
          "[item_repository/loadItemListByString]: Item list load 완료.",
        );

        List<dynamic> data = response.data['items'];

        return data.map((item) => RefrigeratorItem.fromJson(item)).toList();
      } else {
        throw Exception(
          "[item_repository/loadItemListByString]: Json Parse Error",
        );
      }
    } catch (e) {
      AppLogger.logger.e("[item_repository/loadItemListByString]: $e");

      return <RefrigeratorItem>[];
    }
  }

  // itemId로 개별 item 불러오는 함수
  Future<RefrigeratorItem?> loadItem(int itemId) async {
    RestClient client = RestClient(dio);
    try {
      ApiResponse response = await client.getItem(itemId);

      if (response.code == 200) {
        AppLogger.logger.d("[item_repository/loadItem]: Item load 완료.");

        Map<String, dynamic> data = response.data;

        return RefrigeratorItem.fromJson(data);
      } else {
        throw Exception("[item_repository/loadItem]: Json Parse Error");
      }
    } catch (e) {
      AppLogger.logger.e("[item_repository/loadItem]: $e");
    }
  }
}

class Item {}
