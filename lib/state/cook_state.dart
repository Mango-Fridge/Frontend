import 'package:mango/model/cook.dart';

class CookState {
  List<Cook>? cookList;

  CookState({this.cookList});

  CookState copyWith({List<Cook>? cookList}) {
    return CookState(cookList: cookList ?? this.cookList);
  }
}
