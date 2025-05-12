enum AuthPlatform { KAKAO, APPLE }

extension AuthPlatformExtension on AuthPlatform {
  String get name {
    switch (this) {
      case AuthPlatform.KAKAO:
        return "Kakao";
      case AuthPlatform.APPLE:
        return "Apple";
    }
  }
}
