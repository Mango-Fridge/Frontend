import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';

class GrouExistWidget extends ConsumerStatefulWidget {
  const GrouExistWidget({super.key});

  @override
  ConsumerState<GrouExistWidget> createState() => _GroupUserListWidgetState();
}

class _GroupUserListWidgetState extends ConsumerState<GrouExistWidget> {
  String? _selectedGroupId; // 선택된 그룹 ID
  String? _selectedOwner; // 선택된 그룹의 그룹장

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
