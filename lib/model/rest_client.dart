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

  @POST('/api/items')
  Future<ApiResponse> addItem(@Body() Map<String, Object?> body);

  @GET('/api/items/{itemId}')
  Future<ApiResponse> getItem(@Path('itemId') int itemId);

  @PATCH('/api/contents/quantity')
  Future<ApiResponse> setCount(@Body() Map<String, Object?> body);

  @POST('/api/groups/create') // 그룹 생성
  Future<ApiResponse> postCreateGroup(@Body() Map<String, Object?> body);

  @GET('/api/groups/user/{userId}') // 그룹Id, Name 불러오기
  Future<ApiResponse> getGroupInfo(@Path('userId') int userId);

  @POST('/api/groups/id') // 해당 그룹 인원 리스트
  Future<ApiResponse> postGroupUserList(@Body() Map<String, Object?> body);

  @DELETE('/api/groups/user') // 그룹 나가기
  Future<ApiResponse> exitGroup(@Body() Map<String, Object?> body);

  @GET('/api/groups/exist/{groupCode}') // 그룹 존재 여부 확인(유효성)
  Future<ApiResponse> isGroupValid(@Path('groupCode') String groupCode);
}
