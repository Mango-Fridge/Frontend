import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mango/model/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

/// Android : 10.0.2.2 으로 변경하고 "flutter pub run build_runner build" 실행
/// iOS : localhost 혹은 127.0.0.1 으로 변경하고 "flutter pub run build_runner build" 실행
@RestApi(baseUrl: "http://localhost:8080")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @PUT('/user')
  Future<ApiResponse> editNickName(
    @Query('userId') int userId,
    @Query('username') String username,
  );

  @POST('/user/login')
  Future<ApiResponse> getAuthUser(
    @Header("Authorization") String token,
    @Body() Map<String, String> body,
  );

  @DELETE('/user/deleteUser/{userId}')
  Future<ApiResponse> deleteAuthUser(@Path('userId') int userId);

  @POST('/agreement/agree')
  Future<ApiResponse> updateTerms(@Body() Map<String, Object?> body);

  @GET('/api/contents/group/{groupId}')
  Future<ApiResponse> getContentList(@Path('groupId') int groupId);

  @GET('/api/contents/{contentId}')
  Future<ApiResponse> getContent(@Path('contentId') int contentId);

  @GET('/api/items/search')
  Future<ApiResponse> getItemList(
    @Query('keyword') String keyword,
    @Query('page') int page,
  );

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

  @POST('/api/groups/join') // 그룹 참여하기
  Future<ApiResponse> postGroupJoin(@Body() Map<String, Object?> body);

  @PUT('/api/groups/reject') // 그룹 참여 승인 요청 - 거절
  Future<ApiResponse> putGroupReject(@Body() Map<String, Object?> body);

  @PUT('/api/groups/approve') // 그룹 참여 승인 요청 - 승인
  Future<ApiResponse> putGroupApprove(@Body() Map<String, Object?> body);

  @PUT('/api/groups/owner') // 그룹장 임명
  Future<ApiResponse> putGroupOwner(@Body() Map<String, Object?> body);

  @GET('/cooks/list/{groupId}') // cook list 호출
  Future<ApiResponse> getCookList(@Path('groupId') int groupId);

  @POST('/cooks/add2') // cook 추가
  Future<ApiResponse> addCook(@Body() Map<String, Object?> body);

  @DELETE('/cooks/{cookId}') // cook 삭제
  Future<ApiResponse> deleteCook(@Path('cookId') int cookId);

  @GET('/cooks/{cookId}') // 요리 상세정보(칼로리, 탄단지 등)
  Future<ApiResponse> getCookDetail(@Path('cookId') int cookId);

  @GET('/cook-items/{cookId}') // 요리 상세정보 리스트(개수, 중분류 등)
  Future<ApiResponse> getCookDetailList(@Path('cookId') int cookId);
}
