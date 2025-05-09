import 'package:dio/dio.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/model/rest_client.dart';

class CookRepository {
  final Dio dio = Dio();

  // CookRepository() {
  //   dio.interceptors.add(
  //     LogInterceptor(
  //       request: true,
  //       requestHeader: true,
  //       requestBody: true,
  //       responseHeader: true,
  //       responseBody: true,
  //     ),
  //   );
  // }

  // groupId로 cook list 불러오는 함수
  Future<List<Cook>> loadCookList(int groupId) async {
    RestClient client = RestClient(dio);

    // AppLogger.logger.i("Requesting cook list with groupId: $groupId");

    try {
      ApiResponse response = await client.getCookList(groupId);

      if (response.code == 200) {
        AppLogger.logger.i(
          "[cook_repository/loadCookList]: Cook list load 완료.",
        );

        List<dynamic> data = response.data;

        return data.map((item) => Cook.fromJson(item)).toList();
      } else {
        throw Exception('[cook_repository/loadCookList]: Json Parse Error');
      }
    } catch (e) {
      AppLogger.logger.e("[cook_repository/loadCookList]: $e");

      return <Cook>[];
    }
  }

  // cook 추가 함수  -> add2 API
  Future<void> addCook(Cook cook) async {
    RestClient client = RestClient(dio);

    // 전송할 데이터
    final Map<String, Object?> body = <String, Object?>{
      "cookName": cook.cookName,
      "cookMemo": cook.cookMemo,
      "cookNutriKcal": cook.cookNutriKcal,
      "cookNutriCarbohydrate": cook.cookNutriCarbohydrate,
      "cookNutriProtein": cook.cookNutriProtein,
      "cookNutriFat": cook.cookNutriFat,
      "groupId": cook.groupId,
      "cookItems": cook.cookItems,
    };

    try {
      ApiResponse response = await client.addCook(body);

      if (response.code == 200) {
        AppLogger.logger.i("[cook_repository/addCook]: Cook add 완료.");
      } else {
        throw Exception('[cook_repository/addCook]: Json Parse Error');
      }
    } catch (e) {
      throw Exception("[cook_repository/addCook]: $e");
    }
  }

  Future<void> DeleteCook(int cookId) async {
    RestClient client = RestClient(dio);

    try {
      ApiResponse response = await client.deleteCook(cookId);

      if (response.code == 200) {
        AppLogger.logger.i("[cook_repository/deleteCook]: 요리 삭제 성공");
      } else {
        throw Exception('[cook_repository/deleteCook]: Json Parse Error');
      }
    } catch (e) {
      throw Exception("[cook_repository/deleteCook]: $e");
    }
  }

  // 요리 상세정보(칼로리, 탄단지 등)
  Future<Cook> getCookDetail(int cookId) async {
    RestClient client = RestClient(dio);

    // AppLogger.logger.i("Requesting cook detail with cookId: $cookId");

    try {
      ApiResponse response = await client.getCookDetail(cookId);

      if (response.code == 200) {
        AppLogger.logger.i(
          "[cook_repository/getCookDetail]: getCookDetail 완료.",
        );

        Map<String, dynamic> data = response.data;

        return Cook.fromJson(data);
      } else {
        throw Exception('[cook_repository/getCookDetail]: Json Parse Error');
      }
    } catch (e) {
      throw Exception('요리 상세 정보 가져오기 실패');
    }
  }

  // 요리 상세정보 리스트(개수, 중분류 등)
  Future<Cook> getCookDetailList(int cookId) async {
    RestClient client = RestClient(dio);

    // AppLogger.logger.i("Requesting cook detail with cookId: $cookId");

    try {
      ApiResponse response = await client.getCookDetailList(cookId);

      if (response.code == 200) {
        AppLogger.logger.i(
          "[cook_repository/getCookDetail]: getCookDetailList 완료.",
        );

        List<dynamic> dataList = response.data;

        List<CookItems> cookItems =
            dataList
                .map((item) => CookItems.fromJson(item as Map<String, dynamic>))
                .toList();

        return Cook(cookItems: cookItems);
      } else {
        throw Exception(
          '[cook_repository/getCookDetailList]: Json Parse Error',
        );
      }
    } catch (e) {
      throw Exception('요리 상세정보 리스트 가져오기 실패');
    }
  }
}
