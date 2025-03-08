import 'package:mango/model/content.dart';

class RefrigeratorState {
  List<Content>? contentList;
  List<Content>? updateContentList;
  bool isUpdatedContent = false;

  RefrigeratorState({
    this.contentList,
    this.updateContentList,
    this.isUpdatedContent = false,
  });

  RefrigeratorState copyWith({
    List<Content>? contentList,
    List<Content>? updateContentList,
    bool? isUpdatedContent,
  }) {
    return RefrigeratorState(
      contentList: contentList ?? this.contentList,
      updateContentList: updateContentList ?? this.updateContentList,
      isUpdatedContent: isUpdatedContent ?? this.isUpdatedContent,
    );
  }
}
