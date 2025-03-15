import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 사용방법: toastMessage(context, '내용입력')
// 토스트 메시지 커스텀
void toastMessage(BuildContext context, String text) {
  final fToast = FToast();
  fToast.init(context);


  // 커스텀 모양
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(Icons.check), SizedBox(width: 12.0), Text(text)],
    ),
  );

  // 지속 시간 및 위치 커스텀
  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 2),
    positionedToastBuilder: (
      BuildContext context,
      Widget child,
      ToastGravity? gravity,
    ) {
      return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 100,
              child: child,
            ),
          ],
        );
    },
  );
}
