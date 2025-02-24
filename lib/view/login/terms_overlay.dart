import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/login/terms_view.dart';

class TermsOverlay extends ConsumerWidget {
  final String termsType;

  const TermsOverlay({super.key, required this.termsType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginAuthProvider);

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
                onAccept: () {
                  if (user != null && !user.isPrivacyPolicyAccepted) {
                    ref
                        .watch(loginAuthProvider.notifier)
                        .checkForTerms(termsType);
                  } else if (user != null && !user.isTermsAccepted) {
                    ref
                        .watch(loginAuthProvider.notifier)
                        .checkForTerms(termsType);
                  }
                },
                termsType: termsType,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
