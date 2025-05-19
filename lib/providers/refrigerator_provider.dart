import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/content.dart';
import 'package:mango/services/content_repository.dart';
import 'package:mango/state/refrigerator_state.dart';

class RefrigeratorNotifier extends Notifier<RefrigeratorState?> {
  final ContentRepository _contentRepository = ContentRepository();
  RefrigeratorState _refrigeratorState = RefrigeratorState();

  @override
  RefrigeratorState? build() => RefrigeratorState();

  // 초기화 함수
  void resetState() {
    _refrigeratorState = RefrigeratorState();
    state = _refrigeratorState;
  }

  // Content list load 함수
  Future<void> loadContentList(int groupId) async {
    try {
      final List<Content> contentList = await _contentRepository
          .loadContentList(groupId);

      _refrigeratorState.refrigeratorContentList = filterContentList(
        contentList: contentList,
        storageArea: '냉장',
        isExpired: false,
      );
      _refrigeratorState.freezerContentList = filterContentList(
        contentList: contentList,
        storageArea: '냉동',
        isExpired: false,
      );
      _refrigeratorState.refExpContentList = filterContentList(
        contentList: contentList,
        storageArea: '냉장',
        isExpired: true,
      );
      _refrigeratorState.frzExpContentList = filterContentList(
        contentList: contentList,
        storageArea: '냉동',
        isExpired: true,
      );
      _refrigeratorState.contentList = contentList;

      state = state?.copyWith(
        refrigeratorContentList: _refrigeratorState.refrigeratorContentList,
        freezerContentList: _refrigeratorState.freezerContentList,
        refExpContentList: _refrigeratorState.refExpContentList,
        frzExpContentList: _refrigeratorState.frzExpContentList,
        contentList: _refrigeratorState.contentList,
        isLoading: false,
        lastUpdatedTime: DateTime.now(),
      );
    } catch (e) {
      AppLogger.logger.e('[refrigerator_provider/loadContentList]: $e');
    }
  }

  Future<Content?> loadContent(int contentId) async {
    try {
      final Content? content = await _contentRepository.loadContent(contentId);

      return content;
    } catch (e) {
      AppLogger.logger.e('[refrigerator_provider/loadContent]: $e');
    }
  }

  Future<void> setCount(int groupId, List<Content> contentList) async {
    String setCountMessage = '';

    try {
      setCountMessage = await _contentRepository.setCount(groupId, contentList);
    } catch (e) {
      AppLogger.logger.e('[refrigerator_provider/setCount]: $e');
    }

    state = state?.copyWith(setCountMessage: setCountMessage);
  }

  List<Content> filterContentList({
    required List<Content> contentList,
    required String storageArea,
    required bool isExpired,
  }) {
    final List<Content> filtered =
        contentList.where((Content content) {
          final int hoursDiff =
              DateTime.now().difference(content.expDate!).inHours;
          final bool isStorageMatched = content.storageArea == storageArea;

          return isStorageMatched &&
              (isExpired ? hoursDiff > -24 : hoursDiff <= -24);
        }).toList();

    filtered.sort((Content a, Content b) => a.expDate!.compareTo(b.expDate!));
    return filtered;
  }

  int getRefrigeratorContentCount() {
    if (state == null) return 0;

    return (state?.refrigeratorContentList?.length ?? 0) +
        (state?.refExpContentList?.length ?? 0);
  }

  int getFreezerContentCount() {
    if (state == null) return 0;

    return (state?.freezerContentList?.length ?? 0) +
        (state?.frzExpContentList?.length ?? 0);
  }

  // count 증가 함수
  void addContentCount(int contentId) {
    // list 전체 Content에서 count 증가가 반영 된 list
    final List<Content>? addedList =
        state?.contentList?.map((Content content) {
          if (content.contentId == contentId) {
            return content.copyWith(count: content.count + 1);
          }
          return content;
        }).toList();

    List<Content> updateList = state!.updateContentList ?? <Content>[];

    final Content? existingContent =
        updateList
            .where((Content content) => content.contentId == contentId)
            .toList()
            .firstOrNull;

    if (existingContent != null) {
      // update list에 중복 Content가 있다면 count +1
      final Content updatedContent = existingContent.copyWith(
        count: existingContent.count + 1,
      );

      // 개수가 0이 될 시 해당 Content를 update list에서 제거
      if (updatedContent.count == 0) {
        updateList.removeWhere(
          (Content content) => content.contentId == contentId,
        );
        // 비어있다면 뷰 닫기를 위함
        if (updateList.isEmpty) {
          closeUpdateContentCountView();
        }
      } else {
        updateList[updateList.indexOf(existingContent)] = updatedContent;
      }
    } else {
      final Content? newContent =
          addedList
              ?.where((Content content) => content.contentId == contentId)
              .toList()
              .firstOrNull;
      // update list에 중복 Content가 없다면 list에 추가
      if (newContent != null) {
        updateList.add(newContent.copyWith(count: 1));
      }
    }

    state = state?.copyWith(
      contentList: addedList,
      refrigeratorContentList: filterContentList(
        contentList: addedList!,
        storageArea: '냉장',
        isExpired: false,
      ),
      freezerContentList: filterContentList(
        contentList: addedList,
        storageArea: '냉동',
        isExpired: false,
      ),
      refExpContentList: filterContentList(
        contentList: addedList,
        storageArea: '냉장',
        isExpired: true,
      ),
      frzExpContentList: filterContentList(
        contentList: addedList,
        storageArea: '냉동',
        isExpired: true,
      ),
      updateContentList: updateList,
      isUpdatedContent: updateList.isNotEmpty,
    );
  }

  // count 감소 함수
  void reduceContentCount(int contentId) {
    // list 전체 Content에서 count 감소 반영 된 list
    final List<Content>? reducedList =
        state?.contentList?.map((Content content) {
          if (content.contentId == contentId && content.count > 0) {
            return content.copyWith(count: content.count - 1);
          }
          return content;
        }).toList();

    List<Content> updateList = state!.updateContentList ?? <Content>[];

    final Content? existingContent =
        updateList
            .where((Content content) => content.contentId == contentId)
            .toList()
            .firstOrNull;

    if (existingContent != null) {
      // update list에 중복 Content가 있다면 count -1
      final Content updatedContent = existingContent.copyWith(
        count: existingContent.count - 1,
      );

      // 개수가 0이 될 시 해당 Content를 update list에서 제거
      if (updatedContent.count == 0) {
        updateList.removeWhere(
          (Content content) => content.contentId == contentId,
        );
        // 비어있다면 뷰 닫기를 위함
        if (updateList.isEmpty) {
          closeUpdateContentCountView();
        }
      } else {
        updateList[updateList.indexOf(existingContent)] = updatedContent;
      }
    } else {
      final Content? newContent =
          reducedList
              ?.where((Content content) => content.contentId == contentId)
              .toList()
              .firstOrNull;
      // update list에 중복 Content가 없다면 list에 추가
      if (newContent != null) {
        updateList.add(newContent.copyWith(count: -1));
      }
    }

    state = state?.copyWith(
      contentList: reducedList,
      refrigeratorContentList: filterContentList(
        contentList: reducedList!,
        storageArea: '냉장',
        isExpired: false,
      ),
      freezerContentList: filterContentList(
        contentList: reducedList,
        storageArea: '냉동',
        isExpired: false,
      ),
      refExpContentList: filterContentList(
        contentList: reducedList,
        storageArea: '냉장',
        isExpired: true,
      ),
      frzExpContentList: filterContentList(
        contentList: reducedList,
        storageArea: '냉동',
        isExpired: true,
      ),
      updateContentList: updateList,
      isUpdatedContent: updateList.isNotEmpty,
    );
  }

  // update view를 띄우기 위해 상태값을 true로 변경하는 함수
  void openUpdateContentCountView() {
    state = state?.copyWith(isUpdatedContent: true);
  }

  // update view를 닫기 위해 상태값을 false로 변경하는 함수
  void closeUpdateContentCountView() {
    state = state?.copyWith(isUpdatedContent: false);
  }

  // update list 비우는 함수
  void clearUpdateContentList() {
    state = state?.copyWith(updateContentList: <Content>[]);
  }

  // update view에서 취소를 눌렀을 때 count를 되돌려 놓는 함수
  void cancelUpdate() {
    if (state?.contentList != null && state?.updateContentList != null) {
      List<Content> updatedContentList = state!.contentList!;

      // 원래의 것과 update list의 count 계산
      for (Content updateContent in state!.updateContentList!) {
        for (int i = 0; i < updatedContentList.length; i++) {
          if (updatedContentList[i].contentId == updateContent.contentId) {
            updatedContentList[i] = updatedContentList[i].copyWith(
              count: updatedContentList[i].count - updateContent.count,
            );
          }
        }
      }

      state = state!.copyWith(
        contentList: updatedContentList,
        refrigeratorContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉장',
          isExpired: false,
        ),
        freezerContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉동',
          isExpired: false,
        ),
        refExpContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉장',
          isExpired: true,
        ),
        frzExpContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉동',
          isExpired: true,
        ),
        updateContentList: <Content>[],
      );
    }
  }

  // update view에서 x_rouded 버튼을 눌렀을 때 count를 되돌려 놓는 함수
  void removeUpdateContentById(int contentId) {
    List<Content> updatedUpdateList = state?.updateContentList ?? <Content>[];

    Content? contentToRemove =
        updatedUpdateList
            .where((Content content) => content.contentId == contentId)
            .toList()
            .firstOrNull;

    if (contentToRemove != null) {
      List<Content> updatedContentList =
          state!.contentList!.map((Content content) {
            if (content.contentId == contentId) {
              return content.copyWith(
                count: content.count - contentToRemove.count,
              );
            }
            return content;
          }).toList();

      updatedUpdateList.removeWhere(
        (Content content) => content.contentId == contentId,
      );

      state = state?.copyWith(
        contentList: updatedContentList,
        refrigeratorContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉장',
          isExpired: false,
        ),
        freezerContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉동',
          isExpired: false,
        ),
        refExpContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉장',
          isExpired: true,
        ),
        frzExpContentList: filterContentList(
          contentList: updatedContentList,
          storageArea: '냉동',
          isExpired: true,
        ),
        updateContentList: updatedUpdateList,
        isUpdatedContent: updatedUpdateList.isNotEmpty,
      );
    }
  }

  // count가 0인 Content list에서 제거하는 함수
  void removeZeroCountContent() {
    final List<Content> removedList =
        state!.contentList!
            .where((Content content) => content.count > 0)
            .toList();
    state = state?.copyWith(
      contentList: removedList,
      refrigeratorContentList: filterContentList(
        contentList: removedList,
        storageArea: '냉장',
        isExpired: false,
      ),
      freezerContentList: filterContentList(
        contentList: removedList,
        storageArea: '냉동',
        isExpired: false,
      ),
      refExpContentList: filterContentList(
        contentList: removedList,
        storageArea: '냉장',
        isExpired: true,
      ),
      frzExpContentList: filterContentList(
        contentList: removedList,
        storageArea: '냉동',
        isExpired: true,
      ),
    );
  }

  void setLoading(bool isLoading) {
    state = state?.copyWith(isLoading: isLoading);
  }

  String getRemainDate(DateTime expDateTime) {
    final DateTime now = DateTime.now();
    bool isNegative = expDateTime.isBefore(now);
    DateTime start = isNegative ? expDateTime : now;
    DateTime end = isNegative ? now : expDateTime;

    int years = end.year - start.year;
    int months = end.month - start.month;
    int days = end.day - start.day;
    int hours = end.hour - start.hour;
    int minutes = end.minute - start.minute;

    if (minutes < 0) {
      minutes += 60;
      hours -= 1;
    }
    if (hours < 0) {
      hours += 24;
      days -= 1;
    }
    if (days < 0) {
      final DateTime prevMonth = DateTime(end.year, end.month, 0);
      days += prevMonth.day;
      months -= 1;
    }
    if (months < 0) {
      months += 12;
      years -= 1;
    }

    List<String> parts = <String>[];

    if (years > 0) parts.add('$years년');
    if (months > 0) parts.add('$months개월');
    if (days > 0) parts.add('$days일');
    if (hours > 0) parts.add('$hours시간');

    if (years == 0 && months == 0 && hours == 0 && minutes > 0) {
      parts.add('$minutes분');
    }

    if (parts.isEmpty) {
      parts.add('0분');
    }

    return isNegative ? '-${parts.join(' ')}' : parts.join(' ');
  }

  bool getExpiredStatus(DateTime expDateTime) {
    return expDateTime.isBefore(DateTime.now());
  }

  Future<void> setCountZero(int groupId, Content content) async {
    String setCountMessage = '';

    try {
      List<Content> tempContentList = <Content>[];

      content = content.copyWith(
        count:
            -(state?.contentList
                    ?.firstWhere(
                      (Content content) =>
                          content.contentId == content.contentId,
                    )
                    .count ??
                0),
      );
      if (state == null) return;

      final List<Content>? list = state?.contentList;
      if (list == null) return;

      final int index = list.indexWhere(
        (Content e) => e.contentId == content.contentId,
      );

      final List<Content> updatedList = List<Content>.from(list);
      updatedList[index] = updatedList[index].copyWith(count: 0);

      tempContentList.add(content);
      setCountMessage = await _contentRepository.setCount(
        groupId,
        tempContentList,
      );

      state = state?.copyWith(
        contentList: updatedList,
        setCountMessage: setCountMessage,
      );
    } catch (e) {
      AppLogger.logger.e('[refrigerator_provider/setCountZero]: $e');
    }
  }

  Color getColorByRemainTime(DateTime expDateTime) {
    final DateTime now = DateTime.now();
    Duration diff = expDateTime.difference(now);

    if (diff.isNegative) {
      return Colors.grey.shade700;
    }

    final int hours = diff.inHours;

    if (hours < 12) {
      return Colors.red;
    } else if (hours < 24) {
      return Colors.orange;
    } else {
      return Colors.transparent;
    }
  }
}

final NotifierProvider<RefrigeratorNotifier, RefrigeratorState?>
refrigeratorNotifier =
    NotifierProvider<RefrigeratorNotifier, RefrigeratorState?>(
      RefrigeratorNotifier.new,
    );
