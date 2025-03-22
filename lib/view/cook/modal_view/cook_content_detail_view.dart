import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/design.dart';

class CookContentDetailView extends ConsumerStatefulWidget {
  const CookContentDetailView({super.key});

  @override
  ConsumerState<CookContentDetailView> createState() =>
      _CookContentDetailViewState();
}

class _CookContentDetailViewState extends ConsumerState<CookContentDetailView> {
  int contentNumber = 0;

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      contentPadding: const EdgeInsets.all(30.0),
      content: SizedBox(
        width: design.screenHeight * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 25,
          children: <Widget>[
            // 제목
            const Column(
              spacing: 10,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "요리 이름",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("제조사", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Divider(thickness: 1, color: Colors.grey),
              ],
            ),

            // 영양성분 - 칼로리
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: design.screenWidth * 0.63,
                  height: design.screenHeight * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      // cookDetails['nutrients']['calories']
                      child: Text("0 kcal", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),

            // 영양성분 - 탄단지
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                SizedBox(
                  width: design.screenWidth * 0.19,
                  height: design.screenHeight * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('탄', style: TextStyle(fontSize: 12)),
                          Text('0g', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: design.screenWidth * 0.19,
                  height: design.screenHeight * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('단', style: TextStyle(fontSize: 12)),
                          Text('0g', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: design.screenWidth * 0.19,
                  height: design.screenHeight * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('지', style: TextStyle(fontSize: 12)),
                          Text('0g', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 수량 조절 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (contentNumber > 0) {
                          contentNumber--; // - 버튼: contentNumber 감소 (0 이하로 내려가지 않음)
                        }
                      });
                    },
                    icon: const Icon(Icons.remove, size: 20),
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '$contentNumber',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (contentNumber > 0) {
                          contentNumber++; // - 버튼: contentNumber 감소 (0 이하로 내려가지 않음)
                        }
                      });
                    },
                    icon: const Icon(Icons.add, size: 20),
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
              ],
            ),

            // 버튼 row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Text("닫기"),
                ),
                ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Text("추가"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    // throw UnimplementedError();
  }
}

// 모달을 띄우는 함수
void showCookDetailModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CookContentDetailView();
    },
  );
}
