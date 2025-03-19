import 'package:freezed_annotation/freezed_annotation.dart';
part 'content.freezed.dart';
part 'content.g.dart';

@freezed
abstract class Content with _$Content {
  const factory Content({
    required int? contentId,
    required String contentName,
    required String? category,
    required int count,
    required DateTime? regDate,
    required DateTime? expDate,
    required String storageArea,
    required String? memo,
    required String? nutriUnit,
    required int? nutriCapacity,
    required int? nutriKcal,
    required int? nutriCarbohydrate,
    required int? nutriProtein,
    required int? nutriFat,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
