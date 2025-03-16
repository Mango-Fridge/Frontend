import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/cook.dart';

// 요리 이름을 관리하는 StateProvider
final recipeNameProvider = StateProvider<String>((ref) => '');

// 재료를 관리하는 StateProvider
final ingredientsProvider = StateProvider<String>((ref) => '');
