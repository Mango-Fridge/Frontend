import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/login/terms_view.dart';

// 약관 동의 overlay View
class TermsOverlay extends ConsumerWidget {
  final String termsType;

  const TermsOverlay({super.key, required this.termsType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Design design = Design(context);
    final user = ref.watch(loginAuthProvider);

    // 약관 동의 체크
    void onAccept() {
      // 모든 약관이 동의 될때까지,
      if (user != null &&
          (user.agreePrivacyPolicy != true ||
              user.agreeTermsOfService != true)) {
        ref.watch(loginAuthProvider.notifier).checkForTerms(termsType);
      }
    }

    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: SizedBox(
          width: design.termsOverlayWidth,
          height: design.termsOverlayHeight,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TermsView(
                onAccept: onAccept,
                termsType: termsType,
              ), // 약관 동의 View
            ),
          ),
        ),
      ),
    );
  }
}
