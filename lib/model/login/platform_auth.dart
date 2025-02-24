enum AuthPlatform {
  kakao,
  apple,
}

extension AuthPlatformExtension on AuthPlatform {
  String get name {
    switch (this) {
      case AuthPlatform.kakao:
        return "Kakao";
      case AuthPlatform.apple:
        return "Apple";
    }
  }
}