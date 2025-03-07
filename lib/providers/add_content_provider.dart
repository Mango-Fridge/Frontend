import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/add_content_state.dart';

class AddContentNotifier extends Notifier<AddContentState?> {
  AddContentState _addContentState = AddContentState();

  @override
  AddContentState? build() => null;

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

  void updateCapacity(String capacity) {
    if (capacity.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isCapacityEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isCapacityEmpty: false);
    }

    state = _addContentState;
  }

  void updateCalories(String calories) {
    if (calories.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isCaloriesEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isCaloriesEmpty: false);
    }

    state = _addContentState;
  }

  void updateCarbs(String carbs) {
    if (carbs.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isCarbsEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isCarbsEmpty: false);
    }

    state = _addContentState;
  }

  void updateProtein(String protein) {
    if (protein.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isProteinEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isProteinEmpty: false);
    }

    state = _addContentState;
  }

  void updateFat(String fat) {
    if (fat.isNotEmpty) {
      _addContentState = _addContentState.copyWith(isFatEmpty: true);
    } else {
      _addContentState = _addContentState.copyWith(isFatEmpty: false);
    }

    state = _addContentState;
  }

  void setCategory(String category) {
    _addContentState = _addContentState.copyWith(
      selectedContentCategory: category,
    );
    state = _addContentState;
  }

  void setStorage(String storage) {
    _addContentState = _addContentState.copyWith(
      selectedContentStorage: storage,
    );
    state = _addContentState;
  }

  void setRegDate(DateTime regDate) {
    _addContentState = _addContentState.copyWith(selectedRegDate: regDate);
    state = _addContentState;
  }

  void setExpDate(DateTime expDate) {
    _addContentState = _addContentState.copyWith(
      selectedExpDate: expDate,
      isRegDateEmpty: true,
    );

    state = _addContentState;
  }

  void setUnit(String unit) {
    _addContentState = _addContentState.copyWith(
      selectUnit: unit,
      isUnitEmpty: true,
    );

    state = _addContentState;
  }
}

final NotifierProvider<AddContentNotifier, AddContentState?>
addContentProvider = NotifierProvider<AddContentNotifier, AddContentState?>(
  AddContentNotifier.new,
);
