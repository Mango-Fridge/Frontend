import 'package:shared_preferences/shared_preferences.dart';

// shared_preferences를 활용하기 위한 뷰모델

class SharedPrefs {
   Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스를 생성
    prefs.setString('email', email); // email 데이터를 로컬에 저장 
  }

   Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email'); // 저장된 이메일 반환
  }

   Future<void> clearEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email'); // 이메일 삭제 (로그아웃 시)
  }
}