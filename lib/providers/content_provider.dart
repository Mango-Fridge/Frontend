import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/content.dart';
import 'package:mango/services/content_repository.dart';

class RefrigeratorState {
  List<Content>? contentList;
  List<Content>? updateContentList;

  RefrigeratorState({this.contentList, this.updateContentList});

  RefrigeratorState copyWith({
    List<Content>? contentList,
    List<Content>? updateContentList,
  }) {
    return RefrigeratorState(
      contentList: contentList ?? this.contentList,
      updateContentList: updateContentList ?? this.updateContentList,
    );
  }
}

class ContentNotifier extends Notifier<RefrigeratorState?> {
  final ContentRepository _contentRepository = ContentRepository();
  RefrigeratorState _refrigeratorState = RefrigeratorState();

  @override
  RefrigeratorState? build() => null;

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
      _refrigeratorState.contentList = contentList;
      state = _refrigeratorState;
    } catch (e) {
      state = null;
    }
  }

  void addContentCount(String contentId) {
    _refrigeratorState.contentList =
        state?.contentList?.map((Content content) {
          if (content.contentId == contentId) {
            return content.copyWith(count: content.count + 1);
          }
          return content;
        }).toList();

    state = _refrigeratorState;
  }

  void subContentCount(String contentId) {
    state?.contentList =
        state?.contentList?.map((Content content) {
          if (content.contentId == contentId && content.count > 0) {
            return content.copyWith(count: content.count - 1);
          }
          return content;
        }).toList();

    state = state;
  }
}

final NotifierProvider<ContentNotifier, RefrigeratorState?> contentProvider =
    NotifierProvider<ContentNotifier, RefrigeratorState?>(ContentNotifier.new);
