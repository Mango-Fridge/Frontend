import 'package:flutter/material.dart';
import 'package:mango/viewModel/splashView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 232, 176, 7),
        ),
      ),
      home: const SplashView(),
    );
  }
}
