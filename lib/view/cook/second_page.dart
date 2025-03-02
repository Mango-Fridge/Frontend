import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/cook_provider.dart';

// Riverpod 상태를 업데이트하기 위해 ConsumerWidget 사용
class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 텍스트 필드 입력을 관리하기 위한 컨트롤러
    final _recipeNameController = TextEditingController();
    final _ingredientsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('요리하기'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow), // 뒤로 가기 버튼
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 이동
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 여백 추가
        child: Column(
          children: [
            // 요리 이름 입력 필드
            TextField(
              controller: _recipeNameController,
              decoration: const InputDecoration(
                labelText: '요리 이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10), // 간격 추가
            // 재료 입력 필드 (여러 줄 허용)
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: '재료 내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // 최대 3줄 입력 가능
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 입력값 가져오기
                final recipeName = _recipeNameController.text;
                final ingredients = _ingredientsController.text;

                // 입력값이 비어 있지 않으면 상태 업데이트
                if (recipeName.isNotEmpty && ingredients.isNotEmpty) {
                  ref.read(recipeNameProvider.notifier).state = recipeName;
                  ref.read(ingredientsProvider.notifier).state = ingredients;
                  Navigator.pop(context); // cook view로 돌아감
                } else {
                  // 입력값이 비어 있을 경우 경고 메시지
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('요리 이름과 재료를 입력하세요.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child: const Text('저장', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
