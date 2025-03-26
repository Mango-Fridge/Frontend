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

  @POST('/api/groups/create')
  Future<ApiResponse> postCreateGroup(@Body() Map<String, Object?> body);

  @GET('/api/groups/user/{userId}')
  Future<ApiResponse> getGroupInfo(@Path('userId') int userId);
}
