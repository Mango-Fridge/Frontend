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

// 사용법
// final cookState = ref.watch(generateCookProvider); // 상태 감시
// final cookNotifier = ref.read(generateCookProvider.notifier); // 싱테 변경

///////////////////////////////////////////////////////////////////

// 각 변수 상태 관리
final isCookNameFocused = StateProvider<bool>((ref) => false);

final isSearchIngredientFocused = StateProvider<bool>((ref) => false);

final isOpenCookName = StateProvider<bool>((ref) => false);

final isSearchFieldEmpty = StateProvider<bool>((ref) => false);
