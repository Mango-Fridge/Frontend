import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/model/rest_client.dart';

class ItemRepository {
  final Dio dio = Dio();
  Timer? _debounceTimer;

  // 검색어를 받아오면 해당 검색어에 해당하는 결과 리스트 받아오는 api 함수
  Future<List<RefrigeratorItem>> loadItemListByString(String keyword) async {
    final Completer<List<RefrigeratorItem>> completer =
        Completer<List<RefrigeratorItem>>();

    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      RestClient client = RestClient(dio);

      try {
        ApiResponse response = await client.getItemList(keyword);

        if (response.code == 200) {
          AppLogger.logger.d(
            "[item_repository/loadItemListByString]: Item list load 완료.",
          );

          List<dynamic> data = response.data['items'];

          completer.complete(
            data.map((item) => RefrigeratorItem.fromJson(item)).toList(),
          );
        } else {
          throw Exception(
            "[item_repository/loadItemListByString]: Json Parse Error",
          );
        }
      } catch (e) {
        AppLogger.logger.e("[item_repository/loadItemListByString]: $e");

        completer.complete(<RefrigeratorItem>[]);
      }
    });
    return completer.future;

    // await Future.delayed(Duration(seconds: 1));
    // return <RefrigeratorItem>[
    //   RefrigeratorItem(
    //     itemId: 1,
    //     isOpenItem: true,
    //     itemName: "소고기",
    //     category: "육류",
    //     subCategory: "소고기",
    //     brandName: "농협축산",
    //     count: 1,
    //     regDate: DateTime.parse("2025-03-10 14:30:00"),
    //     expDate: DateTime.parse("2025-03-15 23:59:59"),
    //     storageArea: "냉장",
    //     memo: "불고기용",
    //     nutriUnit: "g",
    //     nutriCapacity: 200,
    //     nutriKcal: 250,
    //     nutriCarbohydrate: 10,
    //     nutriProtein: 20,
    //     nutriFat: 18,
    //   ),
    //   RefrigeratorItem(
    //     itemId: 2,
    //     isOpenItem: true,
    //     itemName: "콜라",
    //     category: "음료류",
    //     subCategory: "콜라",
    //     brandName: "코카콜라",
    //     count: 1,
    //     regDate: DateTime.parse("2025-03-08 12:45:10"),
    //     expDate: DateTime.parse("2025-06-08 23:59:59"),
    //     storageArea: "냉장",
    //     memo: "제로콜라",
    //     nutriUnit: "ml",
    //     nutriCapacity: 250,
    //     nutriKcal: 10,
    //     nutriCarbohydrate: 10,
    //     nutriProtein: 10,
    //     nutriFat: 10,
    //   ),
    //   RefrigeratorItem(
    //     itemId: 3,
    //     isOpenItem: true,
    //     itemName: "풀무원 당근",
    //     category: "채소류",
    //     subCategory: "당근",
    //     brandName: "풀무원",
    //     count: 1,
    //     regDate: DateTime.parse("2025-03-09 10:00:00"),
    //     expDate: DateTime.parse("2025-03-20 23:59:59"),
    //     storageArea: "냉장",
    //     memo: "볶음용",
    //     nutriUnit: "g",
    //     nutriCapacity: 100,
    //     nutriKcal: 41,
    //     nutriCarbohydrate: 10,
    //     nutriProtein: 1,
    //     nutriFat: 10,
    //   ),
    //   RefrigeratorItem(
    //     itemId: 4,
    //     isOpenItem: true,
    //     itemName: "촉촉한 초코칩",
    //     category: "과자류",
    //     subCategory: "과자",
    //     brandName: "오리온",
    //     count: 1,
    //     regDate: DateTime.parse("2025-03-05 16:20:30"),
    //     expDate: DateTime.parse("2025-05-05 23:59:59"),
    //     storageArea: "냉동",
    //     memo: "달콤한 간식",
    //     nutriUnit: "g",
    //     nutriCapacity: 50,
    //     nutriKcal: 250,
    //     nutriCarbohydrate: 30,
    //     nutriProtein: 3,
    //     nutriFat: 12,
    //   ),
    //   RefrigeratorItem(
    //     itemId: 5,
    //     isOpenItem: true,
    //     itemName: "민트초코",
    //     category: "아이스크림류",
    //     subCategory: "아이스크림",
    //     brandName: "베스킨라빈스",
    //     count: 1,
    //     regDate: DateTime.parse("2025-03-07 19:15:00"),
    //     expDate: DateTime.parse("2025-09-07 23:59:59"),
    //     storageArea: "냉동",
    //     memo: "디저트",
    //     nutriUnit: "g",
    //     nutriCapacity: 150,
    //     nutriKcal: 200,
    //     nutriCarbohydrate: 20,
    //     nutriProtein: 4,
    //     nutriFat: 10,
    //   ),
    // ];
  }
}
