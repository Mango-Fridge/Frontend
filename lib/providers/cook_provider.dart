import 'package:flutter_riverpod/flutter_riverpod.dart';

// 요리 이름을 관리하는 StateProvider
final recipeNameProvider = StateProvider<String>((ref) => '');

// 재료를 관리하는 StateProvider
final ingredientsProvider = StateProvider<String>((ref) => '');

// 요리 정보를 담을 데이터 클래스
class Recipe {
  final String name;
  final String ingredients;

  Recipe({required this.name, required this.ingredients});

  Recipe copyWith({String? name, String? ingredients}) {
    return Recipe(
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}

// 요리 리스트를 관리하는 StateNotifierProvider
class RecipeNotifier extends StateNotifier<List<Recipe>> {
  RecipeNotifier() : super([]);

  // 새로운 요리 추가
  void addRecipe(String name, String ingredients) {
    if (name.isNotEmpty && ingredients.isNotEmpty) {
      state = [...state, Recipe(name: name, ingredients: ingredients)];
    }
  }

  // 요리 삭제 (선택 사항)
  void removeRecipe(int index) {
    state = [...state]..removeAt(index);
  }

  // 요리 수정 (선택 사항)
  void updateRecipe(int index, String name, String ingredients) {
    if (index >= 0 && index < state.length) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            Recipe(name: name, ingredients: ingredients)
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

// 요리 리스트를 관리하는 StateNotifierProvider
final recipeListProvider = StateNotifierProvider<RecipeNotifier, List<Recipe>>((
  ref,
) {
  return RecipeNotifier();
});
