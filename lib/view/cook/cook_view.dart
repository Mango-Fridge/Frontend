import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/providers/cook_provider.dart';
import 'generate_cook_view.dart';

// Riverpod 상태를 구독하기 위해 ConsumerWidget 사용
class CookView extends ConsumerWidget {
  const CookView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Riverpod Provider에서 요리 리스트를 실시간으로 읽음
    final recipes = ref.watch(recipeListProvider);
    final user = ref.watch(loginAuthProvider); // 로그인 사용자 정보
    final groups = ref.watch(groupProvider); // 그룹 리스트
    final Design design = Design(context);

    // 선택된 그룹 상태 관리 (ref로 관리)
    String? _selectedGroupId; // 선택된 그룹 ID

    // didChangeDependencies에서 그룹 리스트 로드 (postFrameCallback 사용)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null && user.email != null) {
        ref.read(groupProvider.notifier).loadGroupList(user.email!);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('요리')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 그룹 콤보박스 (RefrigeratorView와 동일 위치, + 버튼 상단)
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      // ref를 사용해 상태 갱신
                      ref
                          .read(groupProvider.notifier)
                          .updateSelectedGroupId(value);
                      _selectedGroupId = value; // 로컬 상태 업데이트
                    },
                    itemBuilder: (BuildContext context) {
                      return groups.map<PopupMenuEntry<String>>((Group group) {
                        return PopupMenuItem<String>(
                          value: group.groupId,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                            child: Text(group.groupName),
                          ),
                        );
                      }).toList();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber[300],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        groups.isEmpty
                            ? '그룹을 선택 해 주세요.'
                            : groups
                                .firstWhere(
                                  (group) => group.groupId == _selectedGroupId,
                                  orElse: () => groups.first,
                                )
                                .groupName,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // + 버튼
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  // + 버튼 클릭 시 GenerateCookView로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GenerateCookView(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // 요리 데이터 박스 리스트 (데이터가 있으면 표시)
            if (recipes.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            recipe.ingredients,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              const Expanded(
                child: Center(
                  child: Text(
                    '식사를 추가해보세요',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// GroupNotifier에 선택된 그룹 ID 상태 관리 추가
extension GroupNotifierX on GroupNotifier {
  void updateSelectedGroupId(String? groupId) {
    // 선택된 그룹 ID를 상태로 저장하거나, 필요 시 다른 로직 추가
    // 현재는 단순히 로깅하거나 상태를 유지하는 용도로 사용
    print('Selected group ID: $groupId');
  }
}
