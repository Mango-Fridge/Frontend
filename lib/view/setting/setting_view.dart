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

          ListTile(dense: true, title: Text('계정 및 보안')),
          Card(
            child: ListTile(
              leading: Icon(Icons.person_off),
              title: Text('회원 탈퇴'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('로그아웃'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
          ),

          ListTile(dense: true, title: Text('정보')),
          Card(child: ListTile(title: Text('버전 정보'), trailing: Text("1.1v"))),
          Card(
            child: ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('약관 및 정책'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       final authNotifier = ref.read(loginAuthProvider.notifier);
      //       if (user != null) {
      //         await authNotifier.logout(user!.oauthProvider!);
      //         context.go('/login'); // 로그인 화면
      //       }
      //     },
      //     child: const Text("로그아웃"),
      //   ),
      // ),
    );
  }
}
