import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/content.dart';
import 'package:mango/services/content_repository.dart';

class ContentNotifier extends Notifier<List<Content>> {
  final ContentRepository _contentRepository = ContentRepository();

  @override
  List<Content> build() => <Content>[];

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

  Future<void> loadContentList(String groupId) async {
    try {
      final List<Content> contentList = await _contentRepository
          .loadContentList(groupId);
      state = contentList;
    } catch (e) {
      state = <Content>[];
    }
  }

  void addContentCount(String contentId) {
    state =
        state.map((Content content) {
          if (content.contentId == contentId) {
            return content.copyWith(count: content.count + 1);
          }

          return content;
        }).toList();
  }

  void subContentCount(String contentId) {
    state =
        state.map((Content content) {
          if (content.contentId == contentId && content.count > 0) {
            return content.copyWith(count: content.count - 1);
          }
          return content;
        }).toList();
  }
}

final NotifierProvider<ContentNotifier, List<Content>> contentProvider =
    NotifierProvider<ContentNotifier, List<Content>>(ContentNotifier.new);
