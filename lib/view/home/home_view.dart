import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/login/login_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(loginAuthProvider); // 현재 로그인된 사용자 정보 가져오기
    final authNotifier = ref.read(loginAuthProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("${user?.platform.name ?? '알 수 없음'} 로그인 완료")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("환영합니다, ${user?.email ?? '사용자'}님!", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (user != null) {
                  await authNotifier.logout(user.platform); // 해당 플랫폼에서 로그아웃
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginView()), // 로그인 화면으로 이동
                  );
                }
              },
              child: Text("로그아웃"),
            ),
          ],
        ),
      ),
    );
  }
}