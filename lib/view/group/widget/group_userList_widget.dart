import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/model/group.dart';
import 'package:mango/providers/group_provider.dart';

class GroupUserListWidget extends ConsumerStatefulWidget {
  const GroupUserListWidget({super.key});

  @override
  ConsumerState<GroupUserListWidget> createState() =>
      _GroupUserListWidgetState();
}

class _GroupUserListWidgetState extends ConsumerState<GroupUserListWidget> {
  List<Group>? get _groupList => ref.watch(groupProvider);
  String? _selectedGroup; // 선택된 그룹
  String? _selectedGroupId; // 선택된 그룹 ID
  String? _selectedOwner; // 선택된 그룹의 그룹장

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 그룹 콤보 박스
              PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    _selectedGroupId = value;
                    _selectedGroup =
                        _groupList!
                            .firstWhere((Group group) => group.groupId == value)
                            .groupName;
                    _selectedOwner =
                        _groupList!
                            .firstWhere((Group group) => group.groupId == value)
                            .groupOwner;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return _groupList!.map<PopupMenuEntry<String>>((Group group) {
                    return PopupMenuItem<String>(
                      value: group.groupId,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: design.marginAndPadding,
                        ),
                        child: Text(group.groupName),
                      ),
                    );
                  }).toList();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: design.marginAndPadding,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(_selectedGroup ?? '그룹을 선택 해 주세요.'),
                ),
              ),

              Text(
                '냉장고ID: $_selectedGroupId',
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ExpansionTile(
            title: const Text('그룹원(${1})', style: TextStyle(fontSize: 20)),
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
                          style: const TextStyle(fontSize: 24),
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
