enum AuthPlatform { KAKAO, APPLE }

extension AuthPlatformExtension on AuthPlatform {
  String get name {
    switch (this) {
      case AuthPlatform.KAKAO:
        return "KAKAO";
      case AuthPlatform.APPLE:
        return "APPLE";
    }
  }
}
