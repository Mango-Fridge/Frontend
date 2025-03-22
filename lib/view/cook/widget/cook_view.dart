import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'add_cook_view.dart';

// 요리 리스트를 보여주는 view
class CookView extends ConsumerWidget {
  const CookView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String recipeName = ref.watch(recipeNameProvider);
    // final String ingredients = ref.watch(ingredientsProvider);

    final Design design = Design(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('요리', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: design.screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            // 상단 그룹 선택 박스
            Container(
              width: design.screenWidth * 0.3,
              height: design.screenHeight * 0.05,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: design.screenWidth * 0.03,
              ),
              child: const Row(
                children: [
                  Icon(Icons.keyboard_arrow_down),
                  SizedBox(width: 5),
                  Text('가족 냉장고', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),

            // + 버튼 -> 클릭 시 add_cook_view로 이동
            Center(
              child: Container(
                width: design.screenWidth * 0.9,
                height: design.screenHeight * 0.07,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    context.push('/addCook');
                  },
                ),
              ),
            ),

            SizedBox(height: design.screenHeight * 0.25),

            // Text('레시를 추가해주세요.'),

            // 요리 정보 표시
            // - 추후 provider 생성하며 다시 사용할 예정
            //
            // Center(
            //   child: Column(
            //     children: <Widget>[
            //       if (recipeName.isNotEmpty && ingredients.isNotEmpty) ...[
            //         // 요리 정보가 비워져 있지 않을 때 표시
            //         Text(
            //           '현재 요리: $recipeName',
            //           style: const TextStyle(fontSize: 18),
            //         ),
            //         const SizedBox(height: 10),
            //         Text(
            //           '재료: $ingredients',
            //           style: const TextStyle(fontSize: 14),
            //         ),
            //       ] else ...<Widget>[
            //         // 요리 정보가 비워져 있을 때 표시
            //         const Icon(
            //           Icons.local_dining,
            //           size: 50,
            //           color: Colors.black,
            //         ),
            //         const SizedBox(height: 10),
            //         const Text('식사를 추가해보세요', style: TextStyle(fontSize: 14)),
            //       ],
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
