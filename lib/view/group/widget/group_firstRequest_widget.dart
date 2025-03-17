import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_provider.dart';

class GroupFirstRequestWidget extends ConsumerWidget {
  const GroupFirstRequestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupNameRequest = ref.watch(groupRequestProvider);
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '승인 요청 대기',
            style: TextStyle(
              fontSize: fontSizeMediaQuery * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  groupNameRequest,
                  style: TextStyle(fontSize: fontSizeMediaQuery * 0.04),
                ),
                const Spacer(),
                const Text(
                  '승인 대기 중',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
