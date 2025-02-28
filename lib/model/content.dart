class ContentItem {
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

  ContentItem({
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
}
