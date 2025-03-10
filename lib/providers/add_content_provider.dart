import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/content.dart';
import 'package:mango/services/content_repository.dart';
import 'package:mango/state/add_content_state.dart';

class AddContentNotifier extends Notifier<AddContentState?> {
  final ContentRepository _contentRepository = ContentRepository();
  AddContentState _addContentState = AddContentState();

  @override
  AddContentState? build() => AddContentState();

  void resetState() {
    _addContentState = AddContentState();
    state = _addContentState;
  }

  // Content 저장 함수
  Future<void> saveContent(
    String contentName,
    String category,
    int count,
    DateTime regDate,
    DateTime expDate,
    String storageArea,
    String memo,
    String nutriUnit,
    int nutriCapacity,
    int nutriKcal,
    int nutriCarbohydrate,
    int nutriProtein,
    int nutriFat,
  ) async {
    try {
      await _contentRepository.saveContent(
        Content(
          contentName: contentName,
          category: category,
          count: count,
          regDate: regDate,
          expDate: expDate,
          storageArea: storageArea,
          memo: memo,
          nutriUnit: nutriUnit,
          nutriCapacity: nutriCapacity,
          nutriKcal: nutriKcal,
          nutriCarbohydrate: nutriCarbohydrate,
          nutriProtein: nutriProtein,
          nutriFat: nutriFat,
        ),
      );
    } catch (e) {
      // 에러 처리
    }
  }

  // name error message 관리 함수
  void updateNameErrorMessage(String contentName) {
    if (contentName.length > 20) {
      _addContentState = _addContentState.copyWith(
        contentNameErrorMessage: '물품 이름의 최대 길이는 20자 입니다.',
        isNameEmpty: false,
      );
    } else {
      if (contentName.isNotEmpty) {
        _addContentState = _addContentState.copyWith(
          contentNameErrorMessage: '',
          isNameEmpty: true,
        );
      } else {
        _addContentState = _addContentState.copyWith(
          contentNameErrorMessage: '물품 이름을 입력해 주세요.',
          isNameEmpty: false,
        );
      }
    }

    state = _addContentState;
  }

  // count error message 관리 함수
  void updateCount(String contentCount) {
    if (contentCount.isEmpty) {
      _addContentState = _addContentState.copyWith(
        contentCountErrorMessage: '물품의 개수를 입력해 주세요.',
        isCheckecCount: false,
      );
    } else if (int.parse(contentCount) < 1) {
      _addContentState = _addContentState.copyWith(
        contentCountErrorMessage: '물품의 개수는 1개 이상이여야 합니다.',
        isCheckecCount: false,
      );
    } else {
      _addContentState = _addContentState.copyWith(
        contentCountErrorMessage: '',
        isCheckecCount: true,
      );
    }

    state = _addContentState;
  }

  // capacity의 존재 여부에 따른 상태 처리 함수
  void updateCapacity(String capacity) {
    if (capacity.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isCapacityEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isCapacityEmpty: false);
    }

    state = _addContentState;
  }

  // calories의 존재 여부에 따른 상태 처리 함수
  void updateCalories(String calories) {
    if (calories.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isCaloriesEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isCaloriesEmpty: false);
    }

    state = _addContentState;
  }

  // carbs의 존재 여부에 따른 상태 처리 함수
  void updateCarbs(String carbs) {
    if (carbs.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isCarbsEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isCarbsEmpty: false);
    }

    state = _addContentState;
  }

  // protein의 존재 여부에 따른 상태 처리 함수
  void updateProtein(String protein) {
    if (protein.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isProteinEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isProteinEmpty: false);
    }

    state = _addContentState;
  }

  // fat의 존재 여부에 따른 상태 처리 함수
  void updateFat(String fat) {
    if (fat.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isFatEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isFatEmpty: false);
    }

    state = _addContentState;
  }

  // view에서 선택 된 category 관리 함수
  void setCategory(String category) {
    _addContentState = _addContentState.copyWith(
      selectedContentCategory: category,
    );
    state = _addContentState;
  }

  // view에서 선택 된 storage 관리 함수
  void setStorage(String storage) {
    _addContentState = _addContentState.copyWith(
      selectedContentStorage: storage,
    );
    state = _addContentState;
  }

  // view에서 선택 된 regDate 관리 함수
  void setRegDate(DateTime regDate) {
    _addContentState = _addContentState.copyWith(selectedRegDate: regDate);
    state = _addContentState;
  }

  // view에서 선택 된 expDate 관리 함수
  void setExpDate(DateTime expDate) {
    _addContentState = _addContentState.copyWith(
      selectedExpDate: expDate,
      isRegDateEmpty: true,
    );

    state = _addContentState;
  }

  // view에서 선택 된 unit 관리 함수
  void setUnit(String unit) {
    if (state != null) {
      _addContentState = state!.copyWith(selectedUnit: unit, isUnitEmpty: true);
    }

    state = _addContentState;
  }
}

final NotifierProvider<AddContentNotifier, AddContentState?>
addContentProvider = NotifierProvider<AddContentNotifier, AddContentState?>(
  AddContentNotifier.new,
);
