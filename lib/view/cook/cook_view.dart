import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/cook_provider.dart';
import 'second_page.dart';

class CookView extends ConsumerWidget {
  const CookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // MediaQuery를 통해 화면 크기를 가져오기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 요리 이름과 재료 상태를 읽기
    final recipeName = ref.watch(recipeNameProvider);
    final ingredients = ref.watch(ingredientsProvider);

    // 요리 리스트 상태를 읽기
    final recipeList = ref.watch(recipeListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('요리')),
      body: SingleChildScrollView(
        child: Padding(
          // 좌우, 상하 여백도 화면 크기에 따라 비율로 설정
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// + 버튼을 화면 상단에 배치
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    // + 버튼 클릭 시 go_router를 사용한 화면 이동
                    context.go('/second');
                  },
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // 요리 리스트를 동적으로 표시
              if (recipeList.isNotEmpty)
                Column(
                  children:
                      recipeList.map((recipe) {
                        return Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    recipe.name,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    recipe.ingredients,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2, // 재료가 길 경우 2줄로 제한
                                    overflow:
                                        TextOverflow
                                            .ellipsis, // 텍스트가 길어질 경우 ...으로 표시
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),

              // 요리가 없을 시 아이콘과 안내 문구 표시
              if (recipeList.isEmpty)
                Column(
                  children: [
                    SizedBox(height: screenHeight * 0.3),
                    Icon(
                      Icons.local_dining,
                      size: screenWidth * 0.08,
                      color: Colors.black,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      '식사를 추가해보세요',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
