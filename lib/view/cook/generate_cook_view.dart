import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/cook_provider.dart';

class GenerateCookView extends StatefulWidget {
  const GenerateCookView({super.key});

  @override
  State<GenerateCookView> createState() => _GenerateCookViewState();
}

class _GenerateCookViewState extends State<GenerateCookView> {
  // 텍스트 입력을 관리하기 위한 컨트롤러
  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();

  @override
  void dispose() {
    // 메모리 누수를 방지하기 위해 컨트롤러 정리
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('요리하기'),
        automaticallyImplyLeading: true, // 뒤로 가기 버튼 자동 추가
      ),
      body: Consumer(
        builder: (context, ref, child) {
          // Riverpod Provider에서 상태 가져오기
          final recipeName = ref.watch(recipeNameProvider);
          final ingredients = ref.watch(ingredientsProvider);

          // 입력 필드와 버튼을 포함한 UI
          return Padding(
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
                  onChanged: (value) {
                    ref.read(recipeNameProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 10),
                // 재료 입력 필드
                TextField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(
                    labelText: '재료 내용',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3, // 여러 줄 입력 가능
                  onChanged: (value) {
                    ref.read(ingredientsProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 입력값 가져오기
                    final recipeName = ref.read(recipeNameProvider);
                    final ingredients = ref.read(ingredientsProvider);

                    // 입력값이 비어 있지 않은 경우
                    if (recipeName.isNotEmpty && ingredients.isNotEmpty) {
                      // 요리 목록에 추가
                      ref
                          .read(recipeListProvider.notifier)
                          .addRecipe(recipeName, ingredients);
                      // 입력값 초기화
                      ref.read(recipeNameProvider.notifier).state = '';
                      ref.read(ingredientsProvider.notifier).state = '';
                      _recipeNameController.clear();
                      _ingredientsController.clear();

                      // 이전 화면으로 이동
                      if (GoRouter.of(context).canPop()) {
                        context.pop();
                      } else {
                        context.go('/cook');
                      }
                    } else {
                      // 입력값이 비어 있을 경우 경고
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('요리 이름과 재료를 입력하세요.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  child: const Text(
                    '저장',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
