import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/cook.dart';

class GenerateCookNotifier extends Notifier<Cook> {
  @override
  Cook build() {
    // 초기 상태
    return Cook(
      groupID: '',
      cookingName: '',
      cookingMemo: '',
      cookingNutriKcal: '',
      cookingNutriCarbohydrate: '',
      cookingNutriFat: '',
      cookingNutriProtein: '',
      cookingItems: <Content>[],
    );
  }

  // 요리 추가
  void recipeSave(String name, String text) {
    state = state.copyWith(cookingName: name); // 요리 네임
  }
}

final NotifierProvider<GenerateCookNotifier, Cook> generateCookProvider =
    NotifierProvider<GenerateCookNotifier, Cook>(GenerateCookNotifier.new);

///////////////////////////////////////////////////////////////////

// 각 변수 상태 관리
final StateProvider<bool> isCookNameFocused = StateProvider<bool>(
  (ref) => false,
);

final StateProvider<bool> isSearchIngredientFocused = StateProvider<bool>(
  (ref) => false,
);

final StateProvider<bool> isOpenCookName = StateProvider<bool>((ref) => false);

final StateProvider<bool> isSearchFieldEmpty = StateProvider<bool>(
  (ref) => false,
);
