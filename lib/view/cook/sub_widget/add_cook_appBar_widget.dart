import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/add_cook_provider.dart';

// add_cook_view의 app bar에 들어갈 위젯
class AddCookAppBarWidget extends ConsumerWidget {
  final TextEditingController cookNameController;
  final FocusNode cookNameFocusNode;

  const AddCookAppBarWidget({
    super.key,
    required this.cookNameController,
    required this.cookNameFocusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Design design = Design(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // 포커스 상태에 따른 사이즈 변화 시 애니메이션을 위함
        AnimatedContainer(
          onEnd: () {
            ref.read(isOpenCookName.notifier).state = !ref.read(isOpenCookName);
          },
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width:
              ref.watch(isCookNameFocused)
                  ? design.screenWidth * 0.75
                  : design.screenWidth * 0.44,
          child:
              ref.watch(isCookNameFocused)
                  ? TextField(
                    controller: cookNameController,
                    focusNode: cookNameFocusNode,
                    decoration: InputDecoration(
                      hintText: '요리 이름 입력',
                      suffixIcon: const Icon(Icons.edit, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 16),
                  )
                  : GestureDetector(
                    onTap: () {
                      cookNameFocusNode.requestFocus();
                      ref.read(isCookNameFocused.notifier).state = true;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              cookNameController.text.isEmpty
                                  ? '요리 이름 입력'
                                  : cookNameController.text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color:
                                    cookNameController.text.isEmpty
                                        ? Colors.grey
                                        : Colors.black,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          const Icon(Icons.edit, size: 20),
                        ],
                      ),
                    ),
                  ),
        ),
        SizedBox(width: design.marginAndPadding),
        // 영양성분 표시 box
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width:
              ref.watch(isCookNameFocused)
                  ? design.screenWidth * 0
                  : design.screenWidth * 0.31,
          child:
              !ref.watch(isCookNameFocused) && !ref.watch(isOpenCookName)
                  ? Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Wrap(
                      spacing: 15.0,
                      children: <Widget>[
                        nutrientColumn('열량', '300'),
                        nutrientColumn('탄', '50'),
                        nutrientColumn('단', '20'),
                        nutrientColumn('지', '10'),
                      ],
                    ),
                  )
                  : Container(),
        ),
      ],
    );
  }
}

// 공통적으로 그룹에서 사용할 버튼 - riverpod 사용하지 않는 단순한 코드로, 이와 같이 생성 가능
Widget nutrientColumn(String label, String value) {
  return Column(
    children: <Widget>[
      Text(label, style: const TextStyle(fontSize: 12)),
      Text(value, style: const TextStyle(fontSize: 12)),
    ],
  );
}
