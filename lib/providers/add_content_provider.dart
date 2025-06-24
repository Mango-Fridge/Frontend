import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/services/content_repository.dart';
import 'package:mango/state/add_content_state.dart';

class AddContentNotifier extends Notifier<AddContentState?> {
  final ContentRepository _contentRepository = ContentRepository();
  AddContentState _addContentState = AddContentState();

  @override
  AddContentState? build() => AddContentState();

  // 초기화 함수
  void resetState() {
    _addContentState = AddContentState();
    state = _addContentState;
  }

  // Content 저장 함수
  Future<void> saveItem(
    int groupId,
    String contentName,
    bool isOpen,
    String category,
    String subCategory,
    String brandName,
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
        RefrigeratorItem(
          itemId: groupId,
          itemName: contentName,
          category: category,
          subCategory: subCategory,
          brandName: brandName,
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
          openItem: isOpen,
        ),
      );
    } catch (e) {
      // 에러 처리
    }
  }

  // name error message 관리 함수
  void updateNameErrorMessage(String contentName) {
    if (state != null) {
      if (contentName.isNotEmpty) {
        _addContentState = state!.copyWith(
          contentNameErrorMessage: '',
          isNameEmpty: true,
        );
      } else {
        _addContentState = state!.copyWith(
          contentNameErrorMessage: '물품 이름을 입력해 주세요.',
          isNameEmpty: false,
        );
      }
    }

    state = _addContentState;
  }

  // count error message 관리 함수
  void updateCount(String contentCount) {
    if (state != null) {
      final RegExp regex = RegExp(r'^[0-9]+$');

      if (contentCount.isEmpty) {
        _addContentState = state!.copyWith(
          contentCountErrorMessage: '수량을 입력해 주세요.',
          isCheckecCount: false,
        );
      } else if (!regex.hasMatch(contentCount)) {
        _addContentState = state!.copyWith(
          contentCountErrorMessage: '숫자만 입력 되어야 합니다.',
          isCheckecCount: false,
        );
      } else if (int.parse(contentCount) < 1) {
        _addContentState = state!.copyWith(
          contentCountErrorMessage: '물품의 개수는 1개 이상이여야 합니다.',
          isCheckecCount: false,
        );
      } else {
        _addContentState = state!.copyWith(
          contentCountErrorMessage: '',
          isCheckecCount: true,
        );
      }
    }

    state = _addContentState;
  }

  // capacity의 존재 여부에 따른 상태 처리 함수
  void updateCapacity(String capacity) {
    if (state != null) {
      if (capacity.isNotEmpty) {
        _addContentState = state!.copyWith(isCapacityEmpty: true);
      } else {
        _addContentState = state!.copyWith(isCapacityEmpty: false);
      }
    }

    state = _addContentState;
  }

  // calories의 존재 여부에 따른 상태 처리 함수
  void updateKcal(String kcal) {
    if (state != null) {
      if (kcal.isNotEmpty) {
        _addContentState = state!.copyWith(isKcalEmpty: true);
      } else {
        _addContentState = state!.copyWith(isKcalEmpty: false);
      }
    }

    state = _addContentState;
  }

  // carbs의 존재 여부에 따른 상태 처리 함수
  void updateCarbs(String carbs) {
    if (state != null) {
      if (carbs.isNotEmpty) {
        _addContentState = state!.copyWith(isCarbsEmpty: true);
      } else {
        _addContentState = state!.copyWith(isCarbsEmpty: false);
      }
    }

    state = _addContentState;
  }

  // protein의 존재 여부에 따른 상태 처리 함수
  void updateProtein(String protein) {
    if (state != null) {
      if (protein.isNotEmpty) {
        _addContentState = state!.copyWith(isProteinEmpty: true);
      } else {
        _addContentState = state!.copyWith(isProteinEmpty: false);
      }
    }

    state = _addContentState;
  }

  // fat의 존재 여부에 따른 상태 처리 함수
  void updateFat(String fat) {
    if (state != null) {
      if (fat.isNotEmpty) {
        _addContentState = state!.copyWith(isFatEmpty: true);
      } else {
        _addContentState = state!.copyWith(isFatEmpty: false);
      }
    }

    state = _addContentState;
  }

  // view에서 선택 된 category 관리 함수
  void setCategory(String category) {
    if (state != null) {
      _addContentState = state!.copyWith(selectedContentCategory: category);
    }

    state = _addContentState;
  }

  void setCustomCategory(String customCategory) {
    if (state != null) {
      _addContentState = state!.copyWith(customContentCategory: customCategory);
    }

    state = _addContentState;
  }

  // view에서 선택 된 storage 관리 함수
  void setStorage(String storage) {
    if (state != null) {
      _addContentState = state!.copyWith(selectedContentStorage: storage);
    }

    state = _addContentState;
  }

  // view에서 선택 된 regDate 관리 함수
  void setRegDate(DateTime regDate) {
    if (state != null) {
      _addContentState = state!.copyWith(selectedRegDate: regDate);
    }

    state = _addContentState;
  }

  // view에서 선택 된 expDate 관리 함수
  bool setExpDate(DateTime expDate) {
    if (state != null) {
      if (expDate.isAfter(DateTime.now())) {
        _addContentState = state!.copyWith(
          selectedExpDate: expDate,
          isRegDateEmpty: expDate.isAfter(DateTime.now()),
        );
      }
    }
    state = _addContentState;
    return expDate.isAfter(DateTime.now());
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
