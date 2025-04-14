import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/providers/cook_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/state/cook_state.dart';
import 'package:mango/toastMessage.dart';

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
        toolbarHeight: design.screenHeight * 0.08,
        // + 버튼 -> 클릭 시 add_cook_view로 이동
        // 요리가 없다면 보이지 않음
        actions: <Widget>[
          if (_cookState?.cookList?.isNotEmpty ?? false)
            Padding(
              padding: EdgeInsets.only(right: design.marginAndPadding),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black, size: 25),
                onPressed: () {
                  context.push('/addCook');
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: design.screenWidth * 0.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Expanded(
              child:
                  _cookState != null &&
                          _cookState?.cookList != null &&
                          _cookState!.cookList!.isNotEmpty
                      ? _buildCook(_cookState?.cookList!)
                      : _noCookView(),
            ),
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
          Expanded(
            child: ListView.builder(
              itemCount: cookList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final Cook cook = cookList![index];
                return _buildCookRow(cook);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCookRow(Cook cook) {
    Design design = Design(context);
    return GestureDetector(
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
            // 삭제 버튼
            Transform.translate(
              offset: const Offset(-8, 0), // 삭제 아이콘 왼쪽으로 조금 이동
              // 삭제 버튼
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.red,
                onPressed: () async {
                  if (await ref
                      .read(cookProvider.notifier)
                      .deleteCook(cook.cookId ?? 0)) {
                    FToast().removeCustomToast();
                    toastMessage(context, "${cook.cookName}이(가) 삭제되었습니다.");
                  } else {
                    FToast().removeCustomToast();
                    toastMessage(context, "${cook.cookName}를 삭제하지 못했습니다.");
                  }
                },
              ),
            ),
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
    );
  }

  Widget _noCookView() {
    return Center(
      child: Column(
        children: <Widget>[
          const Spacer(),
          const Icon(Icons.local_dining, size: 50, color: Colors.black),
          const Text(
            "요리를 추가해 보세요!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          // 요리 추가 버튼
          ElevatedButton(
            onPressed: () {
              context.push('/addCook');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 12.0,
              ),
            ),
            child: const Text(
              '요리 추가하기',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
