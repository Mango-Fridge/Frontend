import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/cook_provider.dart';
import 'second_page.dart';

// Riverpod 상태를 구독하기 위해 ConsumerWidget 사용
class CookView extends ConsumerWidget {
  const CookView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Riverpod Provider에서 요리 이름과 재료를 실시간으로 읽음
    final recipeName = ref.watch(recipeNameProvider);
    final ingredients = ref.watch(ingredientsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('요리')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // + 버튼 (상단 박스 형태)
            Container(
              width: 200, // 전체 너비
              height: 50, // 버튼 높이
              color: Colors.yellow, // 이미지와 동일한 색상
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  // + 버튼 클릭 시 두 번째 뷰로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondPage()),
                  );
                },
              ),
            ),
            // 요리 이름 표시, 값이 없으면 "없음" 출력
            Text(
              '현재 요리: ${recipeName.isEmpty ? "없음" : recipeName}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            // 재료 표시, 값이 없으면 "없음" 출력
            Text(
              '재료: ${ingredients.isEmpty ? "없음" : ingredients}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // 요리 추가를 위한 아이콘 (이미지와 유사)
            const Icon(Icons.local_dining, size: 50, color: Colors.black),
            const SizedBox(height: 10),
            const Text('식사를 추가해보세요', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
