class AddContentState {
  // 에러 메세지
  String? contentNameErrorMessage;
  String? contentCountErrorMessage;

  // 선택 값 관리
  String? selectedContentCategory;
  String? selectedContentStorage;
  DateTime? selectedRegDate;
  DateTime? selectedExpDate;
  String? selectUnit;

  // 기본 세부 정보 체크
  bool isNameEmpty;
  bool isCheckedCount;
  bool isRegDateEmpty;

  // 영양 성분 정보 체크
  bool isUnitEmpty;
  bool isCapacityEmpty;
  bool isCaloriesEmpty;
  bool isCarbsEmpty;
  bool isProteinEmpty;
  bool isFatEmpty;

  bool get isNutritionEmpty {
    return isUnitEmpty &&
        isCapacityEmpty &&
        isCaloriesEmpty &&
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
    this.selectedContentStorage,
    this.selectedRegDate,
    this.selectedExpDate,
    this.selectUnit,
    this.isUnitEmpty = false,
    this.isNameEmpty = false,
    this.isCheckedCount = true,
    this.isRegDateEmpty = false,
    this.isCapacityEmpty = false,
    this.isCaloriesEmpty = false,
    this.isCarbsEmpty = false,
    this.isProteinEmpty = false,
    this.isFatEmpty = false,
  });

  AddContentState copyWith({
    String? contentNameErrorMessage,
    String? contentCountErrorMessage,
    String? selectedContentCategory,
    String? selectedContentStorage,
    DateTime? selectedRegDate,
    DateTime? selectedExpDate,
    String? selectUnit,

    bool? isNameEmpty,
    bool? isCheckecCount,
    bool? isRegDateEmpty,

    bool? isUnitEmpty,
    bool? isCapacityEmpty,
    bool? isCaloriesEmpty,
    bool? isCarbsEmpty,
    bool? isProteinEmpty,
    bool? isFatEmpty,
  }) {
    return AddContentState(
      contentNameErrorMessage:
          contentNameErrorMessage ?? this.contentNameErrorMessage,
      contentCountErrorMessage:
          contentCountErrorMessage ?? this.contentCountErrorMessage,
      selectedContentCategory:
          selectedContentCategory ?? this.selectedContentCategory,
      selectedContentStorage:
          selectedContentStorage ?? this.selectedContentStorage,
      selectedRegDate: selectedRegDate ?? this.selectedRegDate,
      selectedExpDate: selectedExpDate ?? this.selectedExpDate,

      isNameEmpty: isNameEmpty ?? this.isNameEmpty,
      isCheckedCount: isCheckecCount ?? this.isCheckedCount,
      isRegDateEmpty: isRegDateEmpty ?? this.isRegDateEmpty,

      isUnitEmpty: isUnitEmpty ?? this.isUnitEmpty,
      isCapacityEmpty: isCapacityEmpty ?? this.isCapacityEmpty,
      isCaloriesEmpty: isCaloriesEmpty ?? this.isCaloriesEmpty,
      isCarbsEmpty: isCarbsEmpty ?? this.isCarbsEmpty,
      isProteinEmpty: isProteinEmpty ?? this.isProteinEmpty,
      isFatEmpty: isFatEmpty ?? this.isFatEmpty,
    );
  }
}
