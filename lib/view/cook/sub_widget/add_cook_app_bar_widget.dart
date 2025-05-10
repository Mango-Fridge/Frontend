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
          width: design.screenWidth * 0.70,
          child:
              _addCookState?.isCookNameFocused ?? false
                  ? TextField(
                    controller: widget.cookNameController,
                    focusNode: widget.cookNameFocusNode,
                    decoration: const InputDecoration(
                      hintText: '요리 제목을 입력해주세요.',
                      suffixIcon: Icon(Icons.edit, size: 20),
                      contentPadding: EdgeInsets.symmetric(
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
                                  ? '요리 제목을 입력해주세요.'
                                  : widget.cookNameController.text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
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
      ],
    );
  }
}