// 디자인 하면서 불필요한 위젯이 되어버림
// 혹시나하여 전체 주석으로 남겨두었습니다.



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mango/state/group_enum_state.dart';
// import 'package:mango/providers/group_enum_state_provider.dart';
// import 'package:mango/providers/group_create_provider.dart';
// import 'package:mango/providers/group_participation_provider.dart';
// import 'package:mango/view/group/sub_widget/group_common_button.dart';
// import 'package:mango/view/group/sub_widget/group_modal_title.dart';

// // 그룹 시작하기 모달 뷰
// class GroupStartView extends ConsumerWidget {
//   const GroupStartView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.45,
//       child: Center(
//         child: Column(
//           children: <Widget>[
//             groupModalTitle(
//               context: context,
//               textTitle: '냉장고 시작하기',
//               textSub: '어떤 방식으로 참여하시겠습니까?',
//             ),
//             const Spacer(),
//             groupCommonButton(
//               context: context,
//               text: "생성하기",
//               onPressed: () {
//                 ref
//                     .read(groupCreateProvider.notifier)
//                     .resetState(); // 생성하기 뷰로 갈 때, 상태초기화
//                 ref.read(groupModalStateProvider.notifier).state =
//                     GroupModalState.create; // '그룹(냉장고)' 생성하기 버튼 클릭 시, 모달 뷰
//               },
//             ),
//             const SizedBox(height: 16),
//             groupCommonButton(
//               context: context,
//               text: "참여하기",
//               onPressed: () {
//                 ref
//                     .read(groupParticipationProvider.notifier)
//                     .resetState(); // 참여하기 뷰로 갈 때, 상태초기화
//                 ref.read(groupModalStateProvider.notifier).state =
//                     GroupModalState
//                         .participation; // '그룹(냉장고)' 참여하기 버튼 클릭 시, 모달 뷰
//               },
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
