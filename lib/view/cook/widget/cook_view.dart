import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/providers/cook_provider.dart';

// 요리 리스트를 보여주는 view
class CookView extends ConsumerStatefulWidget {
  const CookView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CookViewState();
}

class _CookViewState extends ConsumerState<CookView> {
  CookState? get _cookState => ref.watch(cookProvider);

  @override
  void initState() {
    super.initState();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(cookProvider.notifier).loadCookList(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('요리', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: design.screenWidth * 0.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // + 버튼 -> 클릭 시 add_cook_view로 이동
            Padding(
              padding: EdgeInsets.all(design.marginAndPadding),
              child: Container(
                width: design.screenWidth,
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
            Expanded(
              child:
                  _cookState != null &&
                          _cookState?.cookList != null &&
                          _cookState!.cookList!.isNotEmpty
                      ? _buildCook(_cookState?.cookList!)
                      : _noCookView(),
              // : _noCookView(),
            ),

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

  Widget _buildCook(List<Cook>? cookList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cookList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final Cook cook = cookList![index];
                return _buildCookRow(cook);
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildCookRow(Cook cook) {
    Design design = Design(context);
    return GestureDetector(
      onTap: () {
        // 요리 상세 화면
        // context.push(

        // )
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: design.marginAndPadding,
        ),
        padding: EdgeInsets.all(design.marginAndPadding),
        decoration: BoxDecoration(
          color: Colors.amber[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cook.cookingName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${cook.cookingItems[0].contentName} 외 ${cook.cookingItems.length}종',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noCookView() {
    Design design = Design(context);

    return const Center(
      child: Column(
        children: <Widget>[
          Spacer(),
          Icon(Icons.local_dining, size: 50, color: Colors.black),
          Text(
            "요리를 추가해 보세요!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.push('/addContent');
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.amber[300],
          //     foregroundColor: Colors.black,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: const Text("직접 물품 추가"),
          // ),
          Spacer(),
        ],
      ),
    );
  }
}
