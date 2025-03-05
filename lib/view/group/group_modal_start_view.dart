import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 모달 예제 뷰
class GroupModalStartView extends StatelessWidget {
  const GroupModalStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // 배경색
          foregroundColor: Colors.black, // 텍스트색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 버튼 라운딩
          ),
        ),
        onPressed: () {
          showModalStartGroup(context); // '시작하기'버튼 클릭 시, 모달창 띄우기
        },
        child: const Text("시작하기", style: TextStyle(fontSize: 25)),
      ),
    );
  }
}


// 그룹에서 모달창
void showModalStartGroup(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Modal BottomSheet'),
              ElevatedButton(
                child: const Text('Close BottomSheet'),
                onPressed: () => context.pop(), // go_router 사용하여 해당 모달창 닫기
              ),
            ],
          ),
        ),
      );
    },
  );
}
