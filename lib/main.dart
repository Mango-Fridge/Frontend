import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:mango/view/login/exam_apple_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
  await dotenv.load(fileName: 'assets/config/.env');

  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업을 실행하기 전에 위젯 시스템을 초기화
  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_API_KEY')); // 카카오 초기화
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 232, 176, 7),
        ),
      ),
      home: const ExamAppleLogin(), // 초기화면
    );
  }
}
