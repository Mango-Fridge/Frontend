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
}

// 요리 리스트를 관리하는 Provider
final recipeListProvider = StateProvider<List<Recipe>>((ref) => []);
