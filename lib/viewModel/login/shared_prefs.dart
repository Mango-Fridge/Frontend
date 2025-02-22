import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/auth_provider.dart';
import 'package:mango/view/home/home_view.dart';
import 'package:mango/view/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// shared_preferences를 활용하기 위한 뷰모델
class SharedPrefs {
  // 플랫폼과 이메일을 로컬에 저장
  Future<void> saveAuth(String platform, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('platform', platform);
    await prefs.setString('email', email);
  }

  // 로컬에 저장된 이메일 가져오기
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // 로컬에 저장된 플랫폼 가져오기
  Future<String?> getPlatform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('platform');
  }

  // 로컬에 저장한 플랫폼과 이메일 제거
  Future<void> clearAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('platform');
    await prefs.remove('email');
  }
}