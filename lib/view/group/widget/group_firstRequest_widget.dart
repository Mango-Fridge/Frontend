import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/view/group/widget/group_empty_widget.dart';

class GroupFirstrequestWidget extends ConsumerWidget {
  const GroupFirstrequestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('냉장고그룹이름'), 
                Text('승인 대기 중'), 
              ],
            ),
          );
  }
}