import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/cook_provider.dart'; // Riverpod 제공자 가정

class GenerateCookView extends ConsumerStatefulWidget {
  const GenerateCookView({super.key});

  @override
  ConsumerState<GenerateCookView> createState() => _GenerateCookViewState();
}

class _GenerateCookViewState extends ConsumerState<GenerateCookView> {
  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _carbohydratesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();

  @override
  void dispose() {
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    _caloriesController.dispose();
    _carbohydratesController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  void _saveRecipe() {
    final recipeName = ref.read(recipeNameProvider);
    final ingredients = ref.read(ingredientsProvider);
    final memo = ref.read(memoProvider);
    final calories = double.tryParse(_caloriesController.text) ?? 0.0;
    final carbohydrates = double.tryParse(_carbohydratesController.text) ?? 0.0;
    final protein = double.tryParse(_proteinController.text) ?? 0.0;
    final fat = double.tryParse(_fatController.text) ?? 0.0;

    if (recipeName.isNotEmpty && ingredients.isNotEmpty) {
      ref
          .read(recipeListProvider.notifier)
          .addRecipe(
            recipeName,
            ingredients,
            memo,
            calories,
            carbohydrates,
            protein,
            fat,
          );

      // 입력값 초기화
      ref.read(recipeNameProvider.notifier).state = '';
      ref.read(ingredientsProvider.notifier).state = '';
      ref.read(memoProvider.notifier).state = '';
      _recipeNameController.clear();
      _ingredientsController.clear();

      // 뒤로 가기
      context.pop();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('요리 이름과 재료를 입력하세요.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            /// ✅ 요리 이름 입력 필드 (좌측 정렬)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // 배경색 회색
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글게 처리
                ),
                child: Row(
                  children: [
                    /// ✅ 텍스트 입력 필드
                    Expanded(
                      child: TextField(
                        controller: _recipeNameController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: '요리 이름 입력',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          ref.read(recipeNameProvider.notifier).state = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 5),

                    /// ✅ 연필 아이콘 추가
                    const Icon(Icons.edit, color: Colors.grey, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10), // 입력 필드와 영양 정보 박스 사이 간격
            /// ✅ 실시간 영양 정보 박스 (우측 정렬)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[300], // 배경색 설정
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// ✅ 영양소 이름 (열량, 탄, 단, 지)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "열량",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "탄",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "단",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "지",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2), // 줄 간격
                  /// ✅ 실시간으로 업데이트되는 영양 정보
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${ref.watch(caloriesProvider).toStringAsFixed(0)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${ref.watch(carbohydratesProvider).toStringAsFixed(0)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${ref.watch(proteinProvider).toStringAsFixed(0)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${ref.watch(fatProvider).toStringAsFixed(0)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// ✅ 스크롤 가능한 화면 적용
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 재료 입력 필드
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: '재료 내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                ref.read(ingredientsProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 10),

            // 영양소 입력 필드들
            for (var field in [
              {'controller': _caloriesController, 'label': '열량 (kcal)'},
              {'controller': _carbohydratesController, 'label': '탄수화물 (g)'},
              {'controller': _proteinController, 'label': '단백질 (g)'},
              {'controller': _fatController, 'label': '지방 (g)'},
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: field['controller'] as TextEditingController,
                  decoration: InputDecoration(
                    labelText: field['label'] as String,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
          ],
        ),
      ),

      /// ✅ bottomSheet 유지
      bottomSheet: SafeArea(
        child: Container(
          height: 200,
          color: const Color.fromARGB(255, 234, 223, 169),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: '요리에 대한 메모를 입력해보세요',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLength: 90,
                onChanged: (value) {
                  ref.read(memoProvider.notifier).state = value;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveRecipe,
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
