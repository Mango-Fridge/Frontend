import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/login_auth_provider.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({super.key});

  @override
  ConsumerState<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState<SettingView> {
  AuthInfo? get user => ref.watch(loginAuthProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("설정")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final authNotifier = ref.read(loginAuthProvider.notifier);
            if (user != null) {
              await authNotifier.logout(user!.platform);
              context.go('/login'); // 로그인 화면
            }
          },
          child: const Text("로그아웃"),
        ),
      ),
    );
  }
}
