import 'package:flutter/material.dart';

// 모달 예제 뷰
class ModalContentExample extends StatelessWidget {
  const ModalContentExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // 배경색
          foregroundColor: Colors.black, // 텍스트색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 버튼 라운딩
          ),
        ),
        onPressed: () {
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
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Text("시작하기", style: TextStyle(fontSize: 25)),
      ),
    );
  }
}
