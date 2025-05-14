import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/state/add_cook_state.dart';

class AddCookBottomSheetWidget extends ConsumerWidget {
  final VoidCallback onAddPressed; // 추가하기 버튼 콜백
  final String cookName; // 요리 제목 추가
  final List<RefrigeratorItem>? itemListForCook; // 재료 리스트 추가

  const AddCookBottomSheetWidget({
    super.key,
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
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 228, 161, 1),
        borderRadius: BorderRadius.circular(30), // 둥근 모서리 반경 설정
        border: Border.all(color: Colors.brown, width: 1),
      ),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
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
                  child: nutrientColumn('열량', "${_addCookState.totalKcal}kcal"),
                ),
                Expanded(
                  child: nutrientColumn('탄수화물', "${_addCookState.totalCarb}"),
                ),
                Expanded(
                  child: nutrientColumn('단백질', "${_addCookState.totalProtein}"),
                ),
                Expanded(
                  child: nutrientColumn('지방', "${_addCookState.totalFat}"),
                ),
              ],
            ),
          ),

          // 추가하기 버튼
          Container(
            width: 330,
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: isButtonEnabled ? onAddPressed : null, // 콜백 호출
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[400],
                minimumSize: const Size(double.infinity, 40),
                disabledBackgroundColor: Colors.grey[100], // 비활성화 시 색상
                side: BorderSide(
                  color:
                      isButtonEnabled
                          ? Colors.black
                          : Colors.transparent, // 활성화 시 검정 테두리, 비활성화 시 투명
                  width: 1.0, // 테두리 두께
                ),
              ),
              child: Text(
                '추가하기',
                style: TextStyle(
                  fontSize: 23,
                  color:
                      isButtonEnabled
                          ? Colors.black
                          : Color.fromARGB(255, 140, 140, 140),
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
      Text(label, style: const TextStyle(fontSize: 16)),
      Text(value, style: const TextStyle(fontSize: 20)),
    ],
  );
}
