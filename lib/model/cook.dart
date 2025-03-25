import 'content.dart';

class Cook {
  final int groupID;
  final String cookingName;
  final String cookingMemo;
  final String cookingNutriKcal;
  final String cookingNutriCarbohydrate;
  final String cookingNutriFat;
  final String cookingNutriProtein;
  final List<Content> cookingItems;

  Cook({
    required this.groupID,
    required this.cookingName,
    required this.cookingMemo,
    required this.cookingNutriKcal,
    required this.cookingNutriCarbohydrate,
    required this.cookingNutriFat,
    required this.cookingNutriProtein,
    required this.cookingItems,
  });

  // 변경 불가능한 final property를 변경 가능하게 함
  Cook copyWith({
    int? groupID,
    String? cookingName,
    String? cookingMemo,
    String? cookingNutriKcal,
    String? cookingNutriCarbohydrate,
    String? cookingNutriFat,
    String? cookingNutriProtein,
    List<Content>? cookingItems,
  }) {
    return Cook(
      groupID: groupID ?? this.groupID,
      cookingName: cookingName ?? this.cookingName,
      cookingMemo: cookingMemo ?? this.cookingMemo,
      cookingNutriKcal: cookingNutriKcal ?? this.cookingNutriKcal,
      cookingNutriCarbohydrate:
          cookingNutriCarbohydrate ?? this.cookingNutriCarbohydrate,
      cookingNutriFat: cookingNutriFat ?? this.cookingNutriFat,
      cookingNutriProtein: cookingNutriProtein ?? this.cookingNutriProtein,
      cookingItems: cookingItems ?? List.from(this.cookingItems),
    );
  }
}
