import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/login/terms_view.dart';

// 약관 동의 overlay View
class TermsOverlay extends ConsumerWidget {
  final String termsType;

  const TermsOverlay({super.key, required this.termsType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginAuthProvider);

    // 화면 크기를 한 번만 계산하여 변수에 저장
    final screenSize = MediaQuery.of(context).size;

    // 약관 동의 체크
    void _onAccept() {
      if (user != null &&
          (user.isPrivacyPolicyAccepted != true ||
              user.isTermsAccepted != true)) {
        ref.watch(loginAuthProvider.notifier).checkForTerms(termsType);
      }
    }

    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TermsView(
                onAccept: _onAccept,
                termsType: termsType,
              ), // 약관 동의 View
            ),
          ),
        ),
      ),
    );
  }
}
