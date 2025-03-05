import 'package:flutter/material.dart';
import 'package:mango/view/group/subView/group_common_button.dart';
import 'package:mango/view/group/subView/group_modal_title.dart';

// 모달 예제 뷰
class GroupModalStartView extends StatelessWidget {
  const GroupModalStartView({super.key});
  @override
  Widget build(BuildContext context) {
    return groupCommonButton(
      context: context,
      text: "시작하기",
      onPressed: () {
        showModalStartGroup(context);
      },
    );
  }
}

// 그룹에서 모달창
void showModalStartGroup(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 400,
        child: Center(
          child: Column(
            children: <Widget>[
              groupModalTitle(context: context, textTitle: '냉장고 시작하기', textSub: '어떤 방식으로 참여하시겠습니까?'),
              const Spacer(),
              groupCommonButton(
                context: context,
                text: "생성하기",
                onPressed: () {
                  showModalStartGroup(context);
                },
              ),
              const SizedBox(height: 16),
              groupCommonButton(
                context: context,
                text: "참여하기",
                onPressed: () {
                  showModalStartGroup(context);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    },
  );
}
