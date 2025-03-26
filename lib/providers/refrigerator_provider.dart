import 'package:flutter_riverpod/flutter_riverpod.dart';
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

      _refrigeratorState.refrigeratorContentList = getRefrigeratorContentList(
        contentList,
      );
      _refrigeratorState.freezerContentList = getFreezerContentList(
        contentList,
      );
      _refrigeratorState.expContentList = getExpContentList(contentList);
      _refrigeratorState.contentList = contentList;
      state = _refrigeratorState;
    } catch (e) {
      state = null;
    }
  }

  Future<Content?> loadContent(int contentId) async {
    try {
      final Content content = await _contentRepository.loadContent(contentId);
      return content;
    } catch (e) {
      print('refrigerator_provider/loadContent Error: ${e}');

      return null;
    }
  }

  List<Content> getRefrigeratorContentList(List<Content> contentList) {
    List<Content> refrigeratorContentList =
        contentList.where((Content content) {
          bool is24HoursOrMoreLeft =
              DateTime.now().difference(content.expDate!).inHours <= 24;
          bool isFrozen = content.storageArea == '냉장';
          return is24HoursOrMoreLeft && isFrozen;
        }).toList();

    return refrigeratorContentList;
  }

  List<Content> getFreezerContentList(List<Content> contentList) {
    List<Content> freezerContentList =
        contentList.where((Content content) {
          bool is24HoursOrMoreLeft =
              DateTime.now().difference(content.expDate!).inHours <= -24;
          bool isFrozen = content.storageArea == '냉동';
          return is24HoursOrMoreLeft && isFrozen;
        }).toList();

    return freezerContentList;
  }

  List<Content> getExpContentList(List<Content> contentList) {
    List<Content> expContentList =
        contentList.where((Content content) {
          return DateTime.now().difference(content.expDate!).inHours > -24;
        }).toList();

    return expContentList;
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
      refrigeratorContentList: getRefrigeratorContentList(addedList!),
      freezerContentList: getFreezerContentList(addedList),
      expContentList: getExpContentList(addedList),
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
      refrigeratorContentList: getRefrigeratorContentList(reducedList!),
      freezerContentList: getFreezerContentList(reducedList),
      expContentList: getExpContentList(reducedList),
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
        refrigeratorContentList: getRefrigeratorContentList(updatedContentList),
        freezerContentList: getFreezerContentList(updatedContentList),
        expContentList: getExpContentList(updatedContentList),
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
        refrigeratorContentList: getRefrigeratorContentList(updatedContentList),
        freezerContentList: getFreezerContentList(updatedContentList),
        expContentList: getExpContentList(updatedContentList),
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
      refrigeratorContentList: getRefrigeratorContentList(removedList),
      freezerContentList: getFreezerContentList(removedList),
      expContentList: getExpContentList(removedList),
    );
  }
}

final NotifierProvider<RefrigeratorNotifier, RefrigeratorState?>
refrigeratorNotifier =
    NotifierProvider<RefrigeratorNotifier, RefrigeratorState?>(
      RefrigeratorNotifier.new,
    );
