import 'package:mango/model/content.dart';

class RefrigeratorState {
  List<Content>? contentList;
  List<Content>? refrigeratorContentList;
  List<Content>? freezerContentList;
  List<Content>? updateContentList;
  List<Content>? expContentList;
  bool isUpdatedContent = false;

  RefrigeratorState({
    this.contentList,
    this.refrigeratorContentList,
    this.freezerContentList,
    this.updateContentList,
    this.expContentList,
    this.isUpdatedContent = false,
  });

  RefrigeratorState copyWith({
    List<Content>? contentList,
    List<Content>? refrigeratorContentList,
    List<Content>? freezerContentList,
    List<Content>? updateContentList,
    List<Content>? expContentList,
    bool? isUpdatedContent,
  }) {
    return RefrigeratorState(
      contentList: contentList ?? this.contentList,
      refrigeratorContentList:
          refrigeratorContentList ?? this.refrigeratorContentList,
      freezerContentList: freezerContentList ?? this.freezerContentList,
      updateContentList: updateContentList ?? this.updateContentList,
      expContentList: expContentList ?? this.expContentList,
      isUpdatedContent: isUpdatedContent ?? this.isUpdatedContent,
    );
  }
}
