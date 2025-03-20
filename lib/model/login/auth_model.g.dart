// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) => _AuthInfo(
  oauthProvider: $enumDecodeNullable(
    _$AuthPlatformEnumMap,
    json['oauthProvider'],
  ),
  usrId: (json['usrId'] as num?)?.toInt(),
  email: json['email'] as String?,
  usrNm: json['usrNm'] as String?,
  agreePrivacyPolicy: json['agreePrivacyPolicy'] as bool? ?? false,
  agreeTermsOfService: json['agreeTermsOfService'] as bool? ?? false,
);

Map<String, dynamic> _$AuthInfoToJson(_AuthInfo instance) => <String, dynamic>{
  'oauthProvider': _$AuthPlatformEnumMap[instance.oauthProvider],
  'usrId': instance.usrId,
  'email': instance.email,
  'usrNm': instance.usrNm,
  'agreePrivacyPolicy': instance.agreePrivacyPolicy,
  'agreeTermsOfService': instance.agreeTermsOfService,
};

const _$AuthPlatformEnumMap = {
  AuthPlatform.KAKAO: 'KAKAO',
  AuthPlatform.APPLE: 'APPLE',
};
