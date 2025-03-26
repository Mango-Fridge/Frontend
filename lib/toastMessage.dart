import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastmessageType { defaultType, errorType }

// 사용방법: toastMessage(context, '내용입력')
// 토스트 메시지 커스텀
void toastMessage(
  BuildContext context,
  String text, {
  ToastmessageType type = ToastmessageType.defaultType,
}) {
  final fToast = FToast();
  fToast.init(context);

  // 토스트 색상 및 아이콘 변경
  Color backgroundColor =
      (type == ToastmessageType.errorType)
          ? Colors.red[300]!
          : Colors.green[300]!;

  Icon icon =
      (type == ToastmessageType.errorType)
          ? const Icon(Icons.error, color: Colors.black)
          : const Icon(Icons.check, color: Colors.black);

  // 커스텀 모양
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: backgroundColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 12.0),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black),
        ),
      ],
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
        children: <Widget>[Positioned(bottom: 100, child: child)],
      );
    },
  );
}
