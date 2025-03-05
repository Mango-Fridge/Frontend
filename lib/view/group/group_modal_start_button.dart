import 'package:flutter/material.dart';
import 'package:mango/view/group/subView/group_common_button.dart';
import 'package:mango/view/group/subView/group_modal_title.dart';

// 그룹이 없을 때 보이는 '시작하기' 버튼
class GroupModalStartButton extends StatelessWidget {
  const GroupModalStartButton({super.key});
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

// '시작하기' 클릭 시, 처음으로 보이는 모달창
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
                  // 생성하기 모달창
                },
              ),
              const SizedBox(height: 16),
              groupCommonButton(
                context: context,
                text: "참여하기",
                onPressed: () {
                  // 참여하기 모달창
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
