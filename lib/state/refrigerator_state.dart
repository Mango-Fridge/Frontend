import 'package:mango/model/content.dart';

class RefrigeratorState {
  List<Content>? contentList;
  List<Content>? refrigeratorContentList;
  List<Content>? freezerContentList;
  List<Content>? updateContentList;
  List<Content>? refExpContentList;
  List<Content>? frzExpContentList;
  bool isUpdatedContent = false;
  bool? isLoading;
  String? setCountMessage;

  RefrigeratorState({
    this.contentList,
    this.refrigeratorContentList,
    this.freezerContentList,
    this.updateContentList,
    this.refExpContentList,
    this.frzExpContentList,
    this.isUpdatedContent = false,
    this.isLoading,
    this.setCountMessage,
  });

  RefrigeratorState copyWith({
    List<Content>? contentList,
    List<Content>? refrigeratorContentList,
    List<Content>? freezerContentList,
    List<Content>? updateContentList,
    List<Content>? refExpContentList,
    List<Content>? frzExpContentList,
    bool? isUpdatedContent,
    bool? isLoading,
    String? setCountMessage,
  }) {
    return RefrigeratorState(
      contentList: contentList ?? this.contentList,
      refrigeratorContentList:
          refrigeratorContentList ?? this.refrigeratorContentList,
      freezerContentList: freezerContentList ?? this.freezerContentList,
      updateContentList: updateContentList ?? this.updateContentList,
      refExpContentList: refExpContentList ?? this.refExpContentList,
      frzExpContentList: frzExpContentList ?? this.frzExpContentList,
      isUpdatedContent: isUpdatedContent ?? this.isUpdatedContent,
      isLoading: isLoading ?? this.isLoading,
      setCountMessage: setCountMessage ?? this.setCountMessage,
    );
  }
}
