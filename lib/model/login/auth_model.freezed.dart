// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthInfo {

 AuthPlatform? get oauthProvider;// 플랫폼
 int? get usrId;// 사용자 ID
 String? get email;// 이메일
 String? get usrNm;// 닉네임
 bool? get agreePrivacyPolicy;// 개인정보 수집 이용 동의
 bool? get agreeTermsOfService;
/// Create a copy of AuthInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthInfoCopyWith<AuthInfo> get copyWith => _$AuthInfoCopyWithImpl<AuthInfo>(this as AuthInfo, _$identity);

  /// Serializes this AuthInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthInfo&&(identical(other.oauthProvider, oauthProvider) || other.oauthProvider == oauthProvider)&&(identical(other.usrId, usrId) || other.usrId == usrId)&&(identical(other.email, email) || other.email == email)&&(identical(other.usrNm, usrNm) || other.usrNm == usrNm)&&(identical(other.agreePrivacyPolicy, agreePrivacyPolicy) || other.agreePrivacyPolicy == agreePrivacyPolicy)&&(identical(other.agreeTermsOfService, agreeTermsOfService) || other.agreeTermsOfService == agreeTermsOfService));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oauthProvider,usrId,email,usrNm,agreePrivacyPolicy,agreeTermsOfService);

@override
String toString() {
  return 'AuthInfo(oauthProvider: $oauthProvider, usrId: $usrId, email: $email, usrNm: $usrNm, agreePrivacyPolicy: $agreePrivacyPolicy, agreeTermsOfService: $agreeTermsOfService)';
}


}

/// @nodoc
abstract mixin class $AuthInfoCopyWith<$Res>  {
  factory $AuthInfoCopyWith(AuthInfo value, $Res Function(AuthInfo) _then) = _$AuthInfoCopyWithImpl;
@useResult
$Res call({
 AuthPlatform? oauthProvider, int? usrId, String? email, String? usrNm, bool? agreePrivacyPolicy, bool? agreeTermsOfService
});




}
/// @nodoc
class _$AuthInfoCopyWithImpl<$Res>
    implements $AuthInfoCopyWith<$Res> {
  _$AuthInfoCopyWithImpl(this._self, this._then);

  final AuthInfo _self;
  final $Res Function(AuthInfo) _then;

/// Create a copy of AuthInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oauthProvider = freezed,Object? usrId = freezed,Object? email = freezed,Object? usrNm = freezed,Object? agreePrivacyPolicy = freezed,Object? agreeTermsOfService = freezed,}) {
  return _then(_self.copyWith(
oauthProvider: freezed == oauthProvider ? _self.oauthProvider : oauthProvider // ignore: cast_nullable_to_non_nullable
as AuthPlatform?,usrId: freezed == usrId ? _self.usrId : usrId // ignore: cast_nullable_to_non_nullable
as int?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,usrNm: freezed == usrNm ? _self.usrNm : usrNm // ignore: cast_nullable_to_non_nullable
as String?,agreePrivacyPolicy: freezed == agreePrivacyPolicy ? _self.agreePrivacyPolicy : agreePrivacyPolicy // ignore: cast_nullable_to_non_nullable
as bool?,agreeTermsOfService: freezed == agreeTermsOfService ? _self.agreeTermsOfService : agreeTermsOfService // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AuthInfo implements AuthInfo {
  const _AuthInfo({this.oauthProvider, this.usrId, this.email, this.usrNm, this.agreePrivacyPolicy = false, this.agreeTermsOfService = false});
  factory _AuthInfo.fromJson(Map<String, dynamic> json) => _$AuthInfoFromJson(json);

@override final  AuthPlatform? oauthProvider;
// 플랫폼
@override final  int? usrId;
// 사용자 ID
@override final  String? email;
// 이메일
@override final  String? usrNm;
// 닉네임
@override@JsonKey() final  bool? agreePrivacyPolicy;
// 개인정보 수집 이용 동의
@override@JsonKey() final  bool? agreeTermsOfService;

/// Create a copy of AuthInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthInfoCopyWith<_AuthInfo> get copyWith => __$AuthInfoCopyWithImpl<_AuthInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthInfo&&(identical(other.oauthProvider, oauthProvider) || other.oauthProvider == oauthProvider)&&(identical(other.usrId, usrId) || other.usrId == usrId)&&(identical(other.email, email) || other.email == email)&&(identical(other.usrNm, usrNm) || other.usrNm == usrNm)&&(identical(other.agreePrivacyPolicy, agreePrivacyPolicy) || other.agreePrivacyPolicy == agreePrivacyPolicy)&&(identical(other.agreeTermsOfService, agreeTermsOfService) || other.agreeTermsOfService == agreeTermsOfService));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oauthProvider,usrId,email,usrNm,agreePrivacyPolicy,agreeTermsOfService);

@override
String toString() {
  return 'AuthInfo(oauthProvider: $oauthProvider, usrId: $usrId, email: $email, usrNm: $usrNm, agreePrivacyPolicy: $agreePrivacyPolicy, agreeTermsOfService: $agreeTermsOfService)';
}


}

/// @nodoc
abstract mixin class _$AuthInfoCopyWith<$Res> implements $AuthInfoCopyWith<$Res> {
  factory _$AuthInfoCopyWith(_AuthInfo value, $Res Function(_AuthInfo) _then) = __$AuthInfoCopyWithImpl;
@override @useResult
$Res call({
 AuthPlatform? oauthProvider, int? usrId, String? email, String? usrNm, bool? agreePrivacyPolicy, bool? agreeTermsOfService
});




}
/// @nodoc
class __$AuthInfoCopyWithImpl<$Res>
    implements _$AuthInfoCopyWith<$Res> {
  __$AuthInfoCopyWithImpl(this._self, this._then);

  final _AuthInfo _self;
  final $Res Function(_AuthInfo) _then;

/// Create a copy of AuthInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oauthProvider = freezed,Object? usrId = freezed,Object? email = freezed,Object? usrNm = freezed,Object? agreePrivacyPolicy = freezed,Object? agreeTermsOfService = freezed,}) {
  return _then(_AuthInfo(
oauthProvider: freezed == oauthProvider ? _self.oauthProvider : oauthProvider // ignore: cast_nullable_to_non_nullable
as AuthPlatform?,usrId: freezed == usrId ? _self.usrId : usrId // ignore: cast_nullable_to_non_nullable
as int?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,usrNm: freezed == usrNm ? _self.usrNm : usrNm // ignore: cast_nullable_to_non_nullable
as String?,agreePrivacyPolicy: freezed == agreePrivacyPolicy ? _self.agreePrivacyPolicy : agreePrivacyPolicy // ignore: cast_nullable_to_non_nullable
as bool?,agreeTermsOfService: freezed == agreeTermsOfService ? _self.agreeTermsOfService : agreeTermsOfService // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
