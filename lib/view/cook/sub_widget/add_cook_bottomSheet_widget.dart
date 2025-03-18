import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';

class AddCookBottomSheetWidget extends ConsumerWidget {
  final TextEditingController memoController;
  final VoidCallback onAddPressed; // 추가하기 버튼 콜백

  const AddCookBottomSheetWidget({
    super.key,
    required this.memoController,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Design design = Design(context);

    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 메모 입력란
          TextField(
            controller: memoController,
            decoration: InputDecoration(
              hintText: '요리에 대한 메모를 입력해보세요',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              suffixIcon:
                  memoController.text.isNotEmpty
                      ? IconButton(
                        onPressed: () {
                          memoController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                      : null,
            ),
            maxLength: 90,
            minLines: 1,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            onChanged: (String value) {
              // 상태 변경은 부모 위젯에서 setState로 처리
            },
          ),
          // 추가하기 버튼
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: onAddPressed, // 콜백 호출
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text('추가하기', style: TextStyle(color: Colors.black)),
            ),
          ),
          // SizedBox(height: design.marginAndPadding * 3),
        ],
      ),
    );
  }
}
