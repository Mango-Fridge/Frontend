import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/cook_provider.dart';
import 'cook_view.dart';

class GenerateCookView extends ConsumerWidget {
  const GenerateCookView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 텍스트 필드 입력을 관리하기 위한 컨트롤러
    final _recipeNameController = TextEditingController();
    final _ingredientsController = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('요리하기')),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text('저장', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),

      // 바텀 시트
      bottomSheet: SafeArea(
        child: Container(
          height: screenWidth * 0.5,
          color: Colors.amber,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 메모 입력란
              TextField(
                decoration: const InputDecoration(
                  hintText: '요리에 대한 메모를 입력해보세요',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLength: 90,
              ),
              const SizedBox(height: 10),

              // 추가하기 버튼
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text(
                  '추가하기',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
