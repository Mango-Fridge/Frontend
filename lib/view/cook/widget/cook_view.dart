import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/providers/cook_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/state/cook_state.dart';

// 요리 리스트를 보여주는 view
class CookView extends ConsumerStatefulWidget {
  const CookView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CookViewState();
}

class _CookViewState extends ConsumerState<CookView> {
  CookState? get _cookState => ref.watch(cookProvider);
  Group? get _group => ref.watch(groupProvider);

  @override
  void initState() {
    super.initState();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(cookProvider.notifier).loadCookList(_group?.groupId ?? 0);
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
          spacing: 20,
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
            ),

            SizedBox(height: design.screenHeight * 0.25),
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
    return Dismissible(
      key: Key(cook.cookId.toString()), // 각 항목의 고유 키 (cookId 사용)
      direction: DismissDirection.endToStart, // 오른쪽에서 왼쪽으로 스와이프
      background: Container(
        color: Colors.red, // 빨간색 배경
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Text(
          "삭제",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onDismissed: (direction) {
        // 스와이프 완료 시 삭제 동작
        if (cook.cookId != null) {
          ref.read(cookProvider.notifier).deleteCook(cook.cookId!);
          // 삭제 후 사용자에게 알림
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${cook.cookName}이(가) 삭제되었습니다.")),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          context.push('/cookDetail', extra: cook);
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
                          cook.cookName ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    // cookItem 복구 후 사용할 부분
                    //
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     Text(
                    //       '${cook.cookItems[0].contentName} 외 ${cook.cookItems.length}종',
                    //       style: const TextStyle(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noCookView() {
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
          Spacer(),
        ],
      ),
    );
  }
}
