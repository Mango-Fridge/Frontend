import 'package:dio/dio.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/api_response.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/model/rest_client.dart';

class CookRepository {
  final Dio dio = Dio();

  // groupId로 cook list 불러오는 함수
  Future<List<Cook>> loadCookList(int groupId) async {
    RestClient client = RestClient(dio);

    try {
      ApiResponse response = await client.getCookList(groupId);

      if (response.code == 200) {
        AppLogger.logger.i(
          "[cook_repository/loadCookList]: Cook list load 완료.",
        );
        print("[cook_repository/loadCookList]: Cook list load 완료.");

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
}
