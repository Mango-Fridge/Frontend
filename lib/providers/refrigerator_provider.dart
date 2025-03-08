import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/content.dart';
import 'package:mango/services/content_repository.dart';
import 'package:mango/state/refrigerator_state.dart';

class RefrigeratorNotifier extends Notifier<RefrigeratorState?> {
  final ContentRepository _contentRepository = ContentRepository();
  final RefrigeratorState _refrigeratorState = RefrigeratorState();

  @override
  RefrigeratorState? build() => null;

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
      final Content updatedContent = existingContent.copyWith(
        count: existingContent.count + 1,
      );

      if (updatedContent.count == 0) {
        updateList.removeWhere(
          (Content content) => content.contentId == contentId,
        );
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

      if (newContent != null) {
        updateList.add(newContent.copyWith(count: 1));
      }
    }

    state = state?.copyWith(
      contentList: addedList,
      updateContentList: updateList,
      isUpdatedContent: updateList.isNotEmpty,
    );
  }

  void reduceContentCount(String contentId) {
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
      final Content updatedContent = existingContent.copyWith(
        count: existingContent.count - 1,
      );

      if (updatedContent.count == 0) {
        updateList.removeWhere(
          (Content content) => content.contentId == contentId,
        );
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

      if (newContent != null) {
        updateList.add(newContent.copyWith(count: -1));
      }
    }

    state = state?.copyWith(
      contentList: reducedList,
      updateContentList: updateList,
      isUpdatedContent: updateList.isNotEmpty,
    );
  }

  void openUpdateContentCountView() {
    state = state?.copyWith(isUpdatedContent: true);
  }

  void closeUpdateContentCountView() {
    state = state?.copyWith(isUpdatedContent: false);
  }

  void clearUpdateContentList() {
    state = state?.copyWith(updateContentList: <Content>[]);
  }

  void cancelUpdate() {
    if (state?.contentList != null && state?.updateContentList != null) {
      List<Content> updatedContentList = state!.contentList!;

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
        updateContentList: <Content>[],
      );
    }
  }

  void removeUpdateContentById(String contentId) {
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
        updateContentList: updatedUpdateList,
        isUpdatedContent: updatedUpdateList.isNotEmpty,
      );
    }
  }

  void removeZeroCountContent() {
    final List<Content> removedList =
        state!.contentList!
            .where((Content content) => content.count > 0)
            .toList();
    state = state?.copyWith(contentList: removedList);
  }
}

final NotifierProvider<RefrigeratorNotifier, RefrigeratorState?>
refrigeratorNotifier =
    NotifierProvider<RefrigeratorNotifier, RefrigeratorState?>(
      RefrigeratorNotifier.new,
    );
