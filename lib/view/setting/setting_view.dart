import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({super.key});

  @override
  ConsumerState<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState<SettingView> {
  AuthInfo? get user => ref.watch(loginAuthProvider);
  String version = "";

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  // App Version 체크
  Future<void> checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
        forceMaterialTransparency: true, // Color 및 elevation 표시 제거
      ),
      body: ListView(
        // shrinkWrap: true,
        // physics: const ClampingScrollPhysics(),
        children: <Widget>[
          const ListTile(dense: true, title: Text('개인')),
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('닉네임 변경'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => context.push('/editNickName'),
            ),
          ),

          const ListTile(dense: true, title: Text('계정 및 보안')),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_off),
              title: const Text('회원 탈퇴'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('로그아웃'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                logoutDialog(context);
              },
            ),
          ),

          const ListTile(dense: true, title: Text('정보')),
          Card(
            child: ListTile(
              title: const Text('버전 정보'),
              trailing: Text("v$version"),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('약관 및 정책'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => context.push('/settingTerms'),
            ),
          ),
        ],
      ),
    );
  }

  void logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text("로그아웃"),
            content: const Text("정말로 로그아웃 하시겠습니까?"),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  final LoginAuthNotifier authNotifier = ref.read(
                    loginAuthProvider.notifier,
                  );
                  if (user != null) {
                    await authNotifier.logout(user!.oauthProvider!);
                    context.go('/login'); // 로그인 화면
                  }
                },
                child: const Text("확인", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text("취소", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
    );
  }
}
