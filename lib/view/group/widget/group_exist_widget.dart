import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/providers/group_provider.dart';

class GrouExistWidget extends ConsumerStatefulWidget {
  const GrouExistWidget({super.key});

  @override
  ConsumerState<GrouExistWidget> createState() => _GroupUserListWidgetState();
}

class _GroupUserListWidgetState extends ConsumerState<GrouExistWidget> {
  List<Group>? get _groupList => ref.watch(groupProvider);
  String? _selectedGroupName; // 선택된 그룹
  String? _selectedGroupId; // 선택된 그룹 ID
  String? _selectedOwner; // 선택된 그룹의 그룹장

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈

    // @override
    // void didChangeDependencies() {
    //   super.didChangeDependencies();

    //   // view init 후 데이터 처리를 하기 위함
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     ref.watch(refrigeratorNotifier.notifier).resetState();
    //     ref.watch(groupProvider.notifier).loadGroupList('example@example.com');
    //     ref.watch(refrigeratorNotifier.notifier).loadContentList('groupId');
    //   });
    // }

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 그룹 콤보 박스
              // PopupMenuButton<String>(
              //   onSelected: (String value) {
              //     setState(() {
              //       _selectedGroupId = value;
              //       _selectedGroupName =
              //           _groupList!
              //               .firstWhere((Group group) => group.groupId == value)
              //               .groupName;
              //       _selectedOwner =
              //           _groupList!
              //               .firstWhere((Group group) => group.groupId == value)
              //               .groupOwner;
              //     });
              //   },
              //   itemBuilder: (BuildContext context) {
              //     return _groupList!.map<PopupMenuEntry<String>>((Group group) {
              //       return PopupMenuItem<String>(
              //         value: group.groupId,
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(
              //             vertical: 12.0,
              //             horizontal: design.marginAndPadding,
              //           ),
              //           child: Text(group.groupName),
              //         ),
              //       );
              //     }).toList();
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(
              //       vertical: 10.0,
              //       horizontal: design.marginAndPadding,
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.amber[300],
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //     child: Text(_selectedGroupName ?? '그룹을 선택 해 주세요.'),
              //   ),
              // ),

              Text(
                '냉장고ID: $_selectedGroupId',
                style: TextStyle(fontSize: fontSizeMediaQuery * 0.04),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ExpansionTile(
            title: Text(
              '그룹원(${1})',
              style: TextStyle(fontSize: fontSizeMediaQuery * 0.05),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(design.marginAndPadding),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$_selectedOwner',
                          style: TextStyle(fontSize: fontSizeMediaQuery * 0.06),
                        ),
                        const Icon(
                          Icons.emoji_events,
                          size: 26,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
