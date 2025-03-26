import 'package:dio/dio.dart';
import 'package:mango/model/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://localhost:8080")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/user/login')
  Future<ApiResponse> getAuthUser(
    @Header("Authorization") String token,
    @Body() Map<String, String> body,
  );

  @POST('/agreement/agree')
  Future<ApiResponse> updateTerms(@Body() Map<String, Object?> body);

  @GET('/api/contents/group/{groupId}')
  Future<ApiResponse> getContentList(@Path('groupId') int groupId);

  @GET('/api/contents/{contentId}')
  Future<ApiResponse> getContent(@Path('contentId') int contentId);

  @GET('/api/items/search')
  Future<ApiResponse> getItemList(@Query('keyword') String keyword);
}
