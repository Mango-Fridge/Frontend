import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_create_provider.dart';
import 'package:mango/providers/group_participation_provider.dart';

// 생성하기, 참여하기 버튼
Widget groupCommonButton({
  required BuildContext context,
  required String text, // 버튼 텍스트
  required bool isCreateButton, // 생성하기 버튼일 때
  VoidCallback? onPressed, // 버튼 액션
}) {
  return Consumer(
    builder: (context, ref, child) {
      final currentCreateState = ref.read(groupCreateProvider);
      final currentParticipationtState = ref.read(groupParticipationProvider);
      final double fontSizeMediaQuery =
          MediaQuery.of(context).size.width; // 폰트 사이즈

      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber, // 배경색
            foregroundColor: Colors.black, // 텍스트색
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // 버튼 라운딩
            ),
          ),
          onPressed:
              (currentCreateState.isLoadingButton ||
                      currentParticipationtState.isLoadingButton)
                  ? null
                  : onPressed, // 검사 중일때는 버튼활성X
          child:
              (currentCreateState.isLoadingButton ||
                      currentParticipationtState.isLoadingButton)
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                    text,
                    style: TextStyle(fontSize: fontSizeMediaQuery * 0.07),
                  ),
        ),
      );
    },
  );
}
