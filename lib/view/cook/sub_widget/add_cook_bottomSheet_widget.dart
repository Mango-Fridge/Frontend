import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/state/add_cook_state.dart';

class AddCookBottomSheetWidget extends ConsumerWidget {
  final TextEditingController memoController;
  final VoidCallback onAddPressed; // 추가하기 버튼 콜백
  final String cookName; // 요리 제목 추가
  final List<RefrigeratorItem>? itemListForCook; // 재료 리스트 추가

  const AddCookBottomSheetWidget({
    super.key,
    required this.memoController,
    required this.onAddPressed,
    required this.cookName,
    required this.itemListForCook,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AddCookState _addCookState = ref.watch(addCookProvider);
    final Design design = Design(context);

    // 요리 제목이 비어 있지 않고, 재료가 최소 1개 이상인지 확인
    final bool isButtonEnabled =
        cookName.trim().isNotEmpty && (itemListForCook?.isNotEmpty ?? false);

    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 영양성분 표시 box
          Container(
            padding: const EdgeInsets.all(8.0),
            // decoration: BoxDecoration(
            //   color: Colors.grey[200],
            //   borderRadius: BorderRadius.circular(8.0),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: nutrientColumn(
                    '열량',
                    "${_addCookState?.totalKcal}kcal",
                  ),
                ),
                Expanded(
                  child: nutrientColumn('탄수화물', "${_addCookState?.totalCarb}"),
                ),
                Expanded(
                  child: nutrientColumn(
                    '단백질',
                    "${_addCookState?.totalProtein}",
                  ),
                ),
                Expanded(
                  child: nutrientColumn('지방', "${_addCookState?.totalFat}"),
                ),
              ],
            ),
          ),

          // 추가하기 버튼
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: isButtonEnabled ? onAddPressed : null, // 콜백 호출
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
                disabledBackgroundColor: Colors.grey[300], // 비활성화 시 색상
              ),
              child: Text(
                '추가하기',
                style: TextStyle(
                  color:
                      isButtonEnabled
                          ? Colors.black
                          : Color.fromARGB(255, 89, 88, 88),
                ),
              ),
            ),
          ),
          // SizedBox(height: design.marginAndPadding * 3),
        ],
      ),
    );
  }
}

// 공통적으로 그룹에서 사용할 버튼 - riverpod 사용하지 않는 단순한 코드로, 이와 같이 생성 가능
Widget nutrientColumn(String label, String value) {
  return Column(
    children: <Widget>[
      Text(label, style: const TextStyle(fontSize: 20)),
      Text(value, style: const TextStyle(fontSize: 20)),
    ],
  );
}
