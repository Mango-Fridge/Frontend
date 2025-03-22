import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResultCookView extends ConsumerStatefulWidget {
  // final CookDetail cookDetail;

  //, required this.cookDetail
  const ResultCookView({super.key});
  @override
  ConsumerState<ResultCookView> createState() => _ContentDetailViewState();
}

class _ContentDetailViewState extends ConsumerState<ResultCookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text("recipe.name"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              // Memo
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'cookDetail.memo',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // kcal
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'cookDetail.kcal',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 영양성분
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // ${cookDetail.nutrients.split(' ')[1]}
                          "탄",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text("0g", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // ${cookDetail.nutrients.split(' ')[1]}
                          "단",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text("0g", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // ${cookDetail.nutrients.split(' ')[1]}
                          "지",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text("0g", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),

              // 요리 재료들
              const Text(
                "요리 재료",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // ...cookDetail.ingredients.map((ingredient) {
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           ingredient,
              //           style: const TextStyle(fontSize: 14),
              //         ),
              //         const Text(
              //           "4개 / 245 kcal",
              //           style: TextStyle(fontSize: 14, color: Colors.grey),
              //         ),
              //       ],
              //     ),
              //   );
              // }).toList(),

              // 일치하는 물품
              const Text(
                "일치하는 물품",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // ...cookDetail.matchingItems.map((item) {
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           item,
              //           style: const TextStyle(fontSize: 14),
              //         ),
              //         const Text(
              //           "12개 / 3,000 kcal",
              //           style: TextStyle(fontSize: 14, color: Colors.grey),
              //         ),
              //       ],
              //     ),
              //   );
              // }).toList(),

              // 하단 박스 (instruction)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  "해당 음식을 만들기 위해서는 00, 00이 필요로 합니다.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
