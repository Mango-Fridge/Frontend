class AddContentState {
  // 에러 메세지
  String? contentNameErrorMessage;
  String? contentCountErrorMessage;

  // 선택 값 관리
  String? selectedContentCategory;
  String? customContentCategory;
  String? selectedContentStorage;
  DateTime? selectedRegDate;
  DateTime? selectedExpDate;
  String? selectedUnit;

  // 중분류 값 관리
  String? subCategory;

  // 기본 세부 정보 체크
  bool isNameEmpty;
  bool isCheckedCount;
  bool isRegDateEmpty;

  // 영양 성분 정보 체크
  bool isUnitEmpty;
  bool isCapacityEmpty;
  bool isKcalEmpty;
  bool isCarbsEmpty;
  bool isProteinEmpty;
  bool isFatEmpty;

  // 물품 공개 등록 관리
  bool isOpen;

  bool get isNutritionEmpty {
    return isUnitEmpty &&
        isCapacityEmpty &&
        isKcalEmpty &&
        isCarbsEmpty &&
        isProteinEmpty &&
        isFatEmpty;
  }

  bool get isDetailInfoEmpty {
    return isNameEmpty && isCheckedCount && isRegDateEmpty;
  }

  AddContentState({
    this.contentNameErrorMessage,
    this.contentCountErrorMessage,
    this.selectedContentCategory,
    this.customContentCategory,
    this.subCategory,
    this.selectedContentStorage,
    this.selectedRegDate,
    this.selectedExpDate,
    this.selectedUnit,
    this.isUnitEmpty = false,
    this.isNameEmpty = false,
    this.isCheckedCount = true,
    this.isRegDateEmpty = false,
    this.isCapacityEmpty = false,
    this.isKcalEmpty = false,
    this.isCarbsEmpty = false,
    this.isProteinEmpty = false,
    this.isFatEmpty = false,
    this.isOpen = false,
  });

  AddContentState copyWith({
    String? contentNameErrorMessage,
    String? contentCountErrorMessage,
    String? selectedContentCategory,
    String? customContentCategory,
    String? subCategory,
    String? selectedContentStorage,
    DateTime? selectedRegDate,
    DateTime? selectedExpDate,
    String? selectedUnit,

    bool? isNameEmpty,
    bool? isCheckecCount,
    bool? isRegDateEmpty,

    bool? isUnitEmpty,
    bool? isCapacityEmpty,
    bool? isKcalEmpty,
    bool? isCarbsEmpty,
    bool? isProteinEmpty,
    bool? isFatEmpty,

    bool? isOpen,
  }) {
    return AddContentState(
      contentNameErrorMessage:
          contentNameErrorMessage ?? this.contentNameErrorMessage,
      contentCountErrorMessage:
          contentCountErrorMessage ?? this.contentCountErrorMessage,
      selectedContentCategory:
          selectedContentCategory ?? this.selectedContentCategory,
      customContentCategory:
          customContentCategory ?? this.customContentCategory,
      subCategory: subCategory ?? this.subCategory,
      selectedContentStorage:
          selectedContentStorage ?? this.selectedContentStorage,
      selectedRegDate: selectedRegDate ?? this.selectedRegDate,
      selectedExpDate: selectedExpDate ?? this.selectedExpDate,
      selectedUnit: selectedUnit ?? this.selectedUnit,

      isNameEmpty: isNameEmpty ?? this.isNameEmpty,
      isCheckedCount: isCheckecCount ?? this.isCheckedCount,
      isRegDateEmpty: isRegDateEmpty ?? this.isRegDateEmpty,

      isUnitEmpty: isUnitEmpty ?? this.isUnitEmpty,
      isCapacityEmpty: isCapacityEmpty ?? this.isCapacityEmpty,
      isKcalEmpty: isKcalEmpty ?? this.isKcalEmpty,
      isCarbsEmpty: isCarbsEmpty ?? this.isCarbsEmpty,
      isProteinEmpty: isProteinEmpty ?? this.isProteinEmpty,
      isFatEmpty: isFatEmpty ?? this.isFatEmpty,

      isOpen: isOpen ?? this.isOpen,
    );
  }
}
