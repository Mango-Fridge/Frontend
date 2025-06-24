import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/providers/nickName_edit_provider.dart';
import 'package:mango/services/nickName_repository.dart';
import 'package:mango/toastMessage.dart';

class NicknameEditView extends ConsumerStatefulWidget {
  const NicknameEditView({super.key});

  @override
  ConsumerState<NicknameEditView> createState() => _NicknameEditViewState();
}

class _NicknameEditViewState extends ConsumerState<NicknameEditView> {
  AuthInfo? get user => ref.watch(loginAuthProvider);
  TextEditingController nickNameController = TextEditingController();
  final NicknameRepository _nicknameRepository = NicknameRepository();

  @override
  Widget build(BuildContext context) {
    final isCheck = ref.watch(isNicknameValidProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("닉네임 변경")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: nickNameController,
              onChanged: (String value) {
                ref.read(nicknameTextProvider.notifier).state = value;
              },
              style: const TextStyle(fontSize: Design.normalFontSize2),
            ),
            Text(
              "- 현재 닉네임 : ${user!.usrNm}",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("- 그룹원에게 표현되는 닉네임입니다."),
            const Text("- 공백, 특수문자 미포함 2~8자까지 작성 가능합니다."),
            const Text("- 적합하지않은 닉네임 사용시 통지없이 변경됩니다."),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed:
                isCheck
                    ? () async {
                      try {
                        await _nicknameRepository.putEditNickName(
                          user!.usrId!,
                          nickNameController.text,
                        );

                        // 닉네임만 변경하여 상태 갱신
                        final updatedUser = user!.copyWith(
                          usrNm: nickNameController.text,
                        );
                        ref.read(loginAuthProvider.notifier).state =
                            updatedUser;

                        toastMessage(context, "닉네임 변경에 성공했습니다.");
                        context.pop();
                      } catch (e) {
                        toastMessage(
                          context,
                          "닉네임 변경에 실패했습니다.",
                          type: ToastmessageType.errorType,
                        );
                      }
                    }
                    : null,
            child: const Text("변경하기"),
          ),
        ),
      ),
    );
  }
}
