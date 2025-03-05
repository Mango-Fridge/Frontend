import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/cook_provider.dart';
import 'package:mango/view/cook/cook_view.dart';

// Riverpod 상태를 업데이트하기 위해 ConsumerWidget 사용
class GenerateCookView extends ConsumerStatefulWidget {
  const GenerateCookView({super.key});

  @override
  ConsumerState<GenerateCookView> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<GenerateCookView> {
  // 텍스트 필드 입력을 관리하기 위한 컨트롤러
  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();

  @override
  void dispose() {
    // 컨트롤러 정리
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('요리하기'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 10),
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
                final recipeName = _recipeNameController.text.trim();
                final ingredients = _ingredientsController.text.trim();

                // 입력값이 비어 있지 않으면 상태 업데이트
                if (recipeName.isNotEmpty && ingredients.isNotEmpty) {
                  ref
                      .read(recipeListProvider.notifier)
                      .update(
                        (state) => [
                          ...state,
                          Recipe(name: recipeName, ingredients: ingredients),
                        ],
                      );
                  // 이전 상태 초기화
                  ref.read(recipeNameProvider.notifier).state = '';
                  ref.read(ingredientsProvider.notifier).state = '';

                  // 이전 화면으로 이동
                  if (GoRouter.of(context).canPop()) {
                    context.pop();
                  } else {
                    // 이전 화면이 없으면 루트로 이동
                    context.go('/');
                  }
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
