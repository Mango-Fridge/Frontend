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
          children: [
            if (_cookState?.cookList?.isNotEmpty ?? false) ...<Widget>{ // 요리가 없을때, 냉장고명 과 개수가 출력되지 않게 수정
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: design.marginAndPadding,
                ),
                child: Row(
                  children: [
                    Text(
                      '${_group?.groupName}님의 냉장고',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text('총 ${_cookState?.cookList?.length}개의 요리'),
                  ],
                ),
              ),
            },
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
      onDismissed: (direction) async {
        // 스와이프 완료 시 삭제 동작
        if (await ref
            .read(cookProvider.notifier)
            .deleteCook(cook.cookId ?? 0)) {
          // 삭제 후 사용자에게 알림
          FToast().removeCustomToast();
          toastMessage(context, "${cook.cookName}이(가) 삭제되었습니다.");
        } else {
          FToast().removeCustomToast();
          toastMessage(context, "${cook.cookName}를 삭제하지 못했습니다.");
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
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          (cook.cookName ?? '').length > 10
                              ? '${(cook.cookName ?? '').substring(0, 10)}...'
                              : cook.cookName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${cook.cookItems!.first.cookItemName} 외 ${cook.cookItems!.length - 1}개의 재료',
                        ),
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

  Widget _noCookView() {
    final Design design = Design(context);

    return Center(
      child: Column(
        children: <Widget>[
          Spacer(),
          Image.asset(
            "assets/images/null_cook.png",
            scale: design.splashImageSize,
          ),
          const Text(
            "다양한 물품을 검색해서 \n 나만의 요리를 만들어보세요!",
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
