import 'package:flutter_riverpod/flutter_riverpod.dart';

// 닉네임 입력 값 상태
final nicknameTextProvider = StateProvider<String>((ref) => "");

// 닉네임 유효성 검사 Provider
final isNicknameValidProvider = Provider<bool>((ref) {
  final nickname = ref.watch(nicknameTextProvider);
  final trimmed = nickname.trim();

  // 공백 포함 여부
  final hasWhitespace = RegExp(r'\s').hasMatch(nickname);

  // 특수문자 포함 여부
  final hasSpecialChars = RegExp(
    r'[^\uAC00-\uD7A3A-Za-z0-9]',
  ).hasMatch(nickname);

  // 길이 검사 (2자 이상 8자 이하)
  final isCorrectLength = trimmed.length >= 2 && trimmed.length <= 8;

  // 모든 조건 만족 시 true 반환
  return trimmed.isNotEmpty &&
      !hasWhitespace &&
      !hasSpecialChars &&
      isCorrectLength;
});
