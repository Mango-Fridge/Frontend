import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResultCookView extends ConsumerStatefulWidget {
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
              // Memo box
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('cookDetail.memo', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              // kcal box
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
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

              // 영양성분 box
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NutrientLabel(nutriLabel: '탄', nutriCapacity: '3g'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.amber, // 노란색 배경
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              // ${cookDetail.nutrients.split(' ')[1]}
                              "단",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Text("0g", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.amber, // 노란색 배경
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              // ${cookDetail.nutrients.split(' ')[1]}
                              "지",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Text("0g", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),

              // 레시피 재료 list
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

              // 일치하는 물품 list
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

              // 필요한 물품 알려주는 하단 박스
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "해당 음식을 만들기 위해 필요한 재료는",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text("00 00 입니다.", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget NutrientLabel({
    required String nutriLabel,
    required String nutriCapacity,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.amber, // 노란색 배경
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              // ${cookDetail.nutrients.split(' ')[1]}
              nutriLabel,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Text(nutriCapacity, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
