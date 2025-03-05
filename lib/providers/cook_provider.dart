import 'package:flutter_riverpod/flutter_riverpod.dart';

// 요리 이름을 관리하는 StateProvider
final recipeNameProvider = StateProvider<String>((ref) => '');

// 재료를 관리하는 StateProvider
final ingredientsProvider = StateProvider<String>((ref) => '');

// 메모를 관리하는 StateProvider
final memoProvider = StateProvider<String>((ref) => '');

// 열량을 관리하는 StateProvider
final caloriesProvider = StateProvider<double>((ref) => 0.0);

// 탄수화물을 관리하는 StateProvider
final carbohydratesProvider = StateProvider<double>((ref) => 0.0);

// 단백질을 관리하는 StateProvider
final proteinProvider = StateProvider<double>((ref) => 0.0);

// 지방을 관리하는 StateProvider
final fatProvider = StateProvider<double>((ref) => 0.0);

// 요리 리스트를 관리하는 StateNotifierProvider
class RecipeNotifier extends StateNotifier<List<Recipe>> {
  RecipeNotifier() : super([]);

  // 새로운 요리 추가
  void addRecipe(
    String name,
    String ingredients,
    String memo,
    double calories,
    double carbohydrates,
    double protein,
    double fat,
  ) {
    if (name.isNotEmpty && ingredients.isNotEmpty) {
      state = [
        ...state,
        Recipe(
          name: name,
          ingredients: ingredients,
          memo: memo,
          calories: calories,
          carbohydrates: carbohydrates,
          protein: protein,
          fat: fat,
        ),
      ];
    }
  }

  // 요리 삭제 (선택 사항)
  void removeRecipe(int index) {
    state = [...state]..removeAt(index);
  }

  // 요리 수정 (선택 사항)
  void updateRecipe(
    int index,
    String name,
    String ingredients,
    String memo,
    double calories,
    double carbohydrates,
    double protein,
    double fat,
  ) {
    if (index >= 0 && index < state.length) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            Recipe(
              name: name,
              ingredients: ingredients,
              memo: memo,
              calories: calories,
              carbohydrates: carbohydrates,
              protein: protein,
              fat: fat,
            )
          else
            state[i],
      ];
    }
  }

  // 요리 리스트 초기화
  void clearRecipes() {
    state = [];
  }
}

final recipeListProvider = StateNotifierProvider<RecipeNotifier, List<Recipe>>((
  ref,
) {
  return RecipeNotifier();
});

// 요리 정보를 담을 데이터 클래스
class Recipe {
  final String name;
  final String ingredients;
  final String memo; // 메모 속성 추가
  final double calories; // 열량 속성 추가
  final double carbohydrates; // 탄수화물 속성 추가
  final double protein; // 단백질 속성 추가
  final double fat; // 지방 속성 추가

  Recipe({
    required this.name,
    required this.ingredients,
    required this.memo,
    required this.calories,
    required this.carbohydrates,
    required this.protein,
    required this.fat,
  });

  Recipe copyWith({
    String? name,
    String? ingredients,
    String? memo,
    double? calories,
    double? carbohydrates,
    double? protein,
    double? fat,
  }) {
    return Recipe(
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      memo: memo ?? this.memo,
      calories: calories ?? this.calories,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
    );
  }
}
