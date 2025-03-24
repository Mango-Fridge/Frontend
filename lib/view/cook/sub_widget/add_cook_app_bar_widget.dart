import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/state/add_cook_state.dart';

class AddCookAppBarWidget extends ConsumerStatefulWidget {
  final TextEditingController cookNameController;
  final FocusNode cookNameFocusNode;

  const AddCookAppBarWidget({
    super.key,
    required this.cookNameController,
    required this.cookNameFocusNode,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCookAppBarState();
}

class _AddCookAppBarState extends ConsumerState<AddCookAppBarWidget> {
  AddCookState? get _addCookState => ref.watch(addCookProvider);

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // 포커스 상태에 따른 사이즈 변화 시 애니메이션을 위함
        AnimatedContainer(
          onEnd: () {},
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width:
              _addCookState?.isCookNameFocused ?? false
                  ? design.screenWidth * 0.70
                  : design.screenWidth * 0.40,
          child:
              _addCookState?.isCookNameFocused ?? false
                  ? TextField(
                    controller: widget.cookNameController,
                    focusNode: widget.cookNameFocusNode,
                    decoration: InputDecoration(
                      hintText: '요리 이름 입력',
                      suffixIcon: const Icon(Icons.edit, size: 20),
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
                      widget.cookNameFocusNode.requestFocus();
                      ref
                          .read(addCookProvider.notifier)
                          .updateCookNameFocused(true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.cookNameController.text.isEmpty
                                  ? '요리 이름 입력'
                                  : widget.cookNameController.text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color:
                                    widget.cookNameController.text.isEmpty
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
        // 영양성분 표시 box
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width:
              _addCookState?.isCookNameFocused ?? false
                  ? design.screenWidth * 0
                  : design.screenWidth * 0.335,
          child:
              !(_addCookState?.isCookNameFocused ?? false)
                  ? Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: nutrientColumn(
                            '열량',
                            "${_addCookState?.totalKcal}",
                          ),
                        ),
                        Expanded(
                          child: nutrientColumn(
                            '탄',
                            "${_addCookState?.totalCarb}",
                          ),
                        ),
                        Expanded(
                          child: nutrientColumn(
                            '단',
                            "${_addCookState?.totalProtein}",
                          ),
                        ),
                        Expanded(
                          child: nutrientColumn(
                            '지',
                            "${_addCookState?.totalFat}",
                          ),
                        ),
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
