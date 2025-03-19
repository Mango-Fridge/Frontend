import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://localhost:8080")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/user/login')
  Future<Users> getAuthUser(
    @Header("Authorization") String token,
    @Body() Map<String, String> body,
  );
}

@JsonSerializable()
class Users {
  String? email;
  int? usrId;
  String? oauthProvider;
  bool? agreePrivacyPolicy;
  bool? agreeTermsOfService;

  Users({
    this.email,
    this.usrId,
    this.oauthProvider,
    this.agreePrivacyPolicy,
    this.agreeTermsOfService,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
