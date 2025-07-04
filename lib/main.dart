import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mango/design.dart';
import 'package:mango/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');

  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업을 실행하기 전에 위젯 시스템을 초기화
  await initializeDateFormatting('ko', null);
  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_API_KEY')); // 카카오 초기화

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return MaterialApp.router(
      locale: const Locale('ko', 'KR'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Mainfonts',
        colorScheme: const ColorScheme.light(
          primary: Colors.black, // 메인 색상
          secondary: Colors.amber, // 보조 색상
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),
      ),
      routerConfig: goRouter,
      localizationsDelegates: const <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[Locale('ko', 'KR')],
    );
  }
}
