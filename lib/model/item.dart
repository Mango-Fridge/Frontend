class RefrigeratorItem {
  final String groupId;
  final bool isOpenItem;
  final String itemName;
  final String category;
  final String brandName;
  final int count;
  final DateTime regDate;
  final DateTime expDate;
  final String storageArea;
  final String memo;
  final String nutriUnit;
  final int nutriCapacity;
  final int nutriKcal;
  final int nutriCarbohydrate;
  final int nutriProtein;
  final int nutriFat;

  RefrigeratorItem({
    required this.groupId,
    required this.isOpenItem,
    required this.itemName,
    required this.category,
    required this.brandName,
    required this.count,
    required this.regDate,
    required this.expDate,
    required this.storageArea,
    required this.memo,
    required this.nutriUnit,
    required this.nutriCapacity,
    required this.nutriKcal,
    required this.nutriCarbohydrate,
    required this.nutriProtein,
    required this.nutriFat,
  });

  RefrigeratorItem copyWith({
    String? groupId,
    bool? isOpenItem,
    String? itemName,
    String? category,
    String? brandName,
    int? count,
    DateTime? regDate,
    DateTime? expDate,
    String? storageArea,
    String? memo,
    String? nutriUnit,
    int? nutriCapacity,
    int? nutriKcal,
    int? nutriCarbohydrate,
    int? nutriProtein,
    int? nutriFat,
  }) {
    return RefrigeratorItem(
      groupId: groupId ?? this.groupId,
      isOpenItem: isOpenItem ?? this.isOpenItem,
      itemName: itemName ?? this.itemName,
      category: category ?? this.category,
      brandName: brandName ?? this.brandName,
      count: count ?? this.count,
      regDate: regDate ?? this.regDate,
      expDate: expDate ?? this.expDate,
      storageArea: storageArea ?? this.storageArea,
      memo: memo ?? this.memo,
      nutriUnit: nutriUnit ?? this.nutriUnit,
      nutriCapacity: nutriCapacity ?? this.nutriCapacity,
      nutriKcal: nutriKcal ?? this.nutriKcal,
      nutriCarbohydrate: nutriCarbohydrate ?? this.nutriCarbohydrate,
      nutriProtein: nutriProtein ?? this.nutriProtein,
      nutriFat: nutriFat ?? this.nutriFat,
    );
  }
}
