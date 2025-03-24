import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/services/cook_repository.dart';
import 'package:mango/state/cook_state.dart';

class CookNotifier extends Notifier<CookState?> {
  CookRepository _cookRepository = CookRepository();
  @override
  CookState? build() => CookState();

  // cook list load 함수
  Future<void> loadCookList(int groupId) async {
    state = state?.copyWith(
      cookList: await _cookRepository.loadCookList(groupId),
    );
  }
}

final NotifierProvider<CookNotifier, CookState?> cookProvider =
    NotifierProvider<CookNotifier, CookState?>(CookNotifier.new);
