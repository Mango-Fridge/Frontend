import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/cook_provider.dart';
import 'second_page.dart';

// Riverpod 상태를 구독하기 위해 ConsumerWidget 사용
class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Riverpod Provider에서 요리 이름과 재료를 실시간으로 읽음
    final recipeName = ref.watch(recipeNameProvider);
    final ingredients = ref.watch(ingredientsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('요리하기'), // 앱 바의 제목 설정
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple), // 뒤로 가기 버튼
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 이동
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 요리 이름 표시, 값이 없으면 "없음" 출력
            Text(
              '현재 요리: ${recipeName.isEmpty ? "없음" : recipeName}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10), // 간격 추가
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // 이미지의 색상과 일치
        onPressed: () {
          // + 버튼 클릭 시 두 번째 뷰로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white), // + 아이콘
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple, // 이미지와 동일한 푸터 색상
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 하단 네비게이션 바 버튼들 (이미지 기반)
            TextButton(
              onPressed: () {},
              child: const Text('홈', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('그룹', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('설정', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
