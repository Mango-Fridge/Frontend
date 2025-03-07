import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/content.dart';
import 'package:mango/services/content_repository.dart';

class ContentNotifier extends Notifier<List<Content>> {
  final _contentRepository = ContentRepository();

  @override
  List<Content> build() => <Content>[];

  Future<void> saveContent(Content content) async {
    try {
      _contentRepository.saveContent(content);
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
