import 'package:flutter/material.dart';

class hello extends StatefulWidget {
  const hello({super.key});

  @override
  State<hello> createState() => _helloState();
}

class _helloState extends State<hello> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(padding: EdgeInsets.all(2)));
  }
}
