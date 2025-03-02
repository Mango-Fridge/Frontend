class Content {
  final String contentId;
  final String contentName;
  final String category;
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

  Content({
    required this.contentId,
    required this.contentName,
    required this.category,
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

  Content copyWith({
    String? contentId,
    String? contentName,
    String? category,
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
    return Content(
      contentId: contentId ?? this.contentId,
      contentName: contentName ?? this.contentName,
      category: category ?? this.category,
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
