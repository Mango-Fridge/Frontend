import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/services/cook_repository.dart';
import 'package:mango/state/cook_state.dart';
import 'package:mango/model/cook.dart';

class CookNotifier extends Notifier<CookState?> {
  CookRepository _cookRepository = CookRepository();
  CookState _cookState = CookState();

  @override
  CookState? build() => CookState();

  // Cook list load 함수
  Future<void> loadCookList(int groupId) async {
    try {
      final List<Cook> cookList = await _cookRepository.loadCookList(groupId);
      _cookState.cookList = cookList;

      state = state?.copyWith(cookList: _cookState.cookList);
    } catch (e) {
      AppLogger.logger.e('[refrigerator_provider/loadContentList]: $e');
    }
  }
}

final NotifierProvider<CookNotifier, CookState?> cookProvider =
    NotifierProvider<CookNotifier, CookState?>(CookNotifier.new);
