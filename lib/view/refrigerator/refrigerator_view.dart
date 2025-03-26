import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/refrigerator_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/state/refrigerator_state.dart';
import 'package:mango/view/refrigerator/content_detail_view.dart';

// 냉장고 화면
class RefrigeratorView extends ConsumerStatefulWidget {
  const RefrigeratorView({super.key});

  @override
  ConsumerState<RefrigeratorView> createState() => _RefrigeratorViewState();
}

class _RefrigeratorViewState extends ConsumerState<RefrigeratorView> {
  // 상태관리 관련 선언부
  AuthInfo? get user => ref.watch(loginAuthProvider);
  Group? get _group => ref.watch(groupProvider);
  RefrigeratorState? get _refrigeratorState => ref.watch(refrigeratorNotifier);

  // initState()로 watch하니까 자꾸 에러나서 찾아보니 initState 후에 호출되는 함수라고 하여 사용.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(refrigeratorNotifier.notifier).resetState();
      ref.watch(groupProvider.notifier).loadGroup(user?.usrId ?? 0);
      ref.watch(refrigeratorNotifier.notifier).loadContentList(7);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: double.infinity,
        leading: Row(
          spacing: 15,
          children: <Widget>[
            Container(),
            Image.asset("assets/images/title.png", width: design.homeImageSize),
            const Text("Mango"),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        // 새로고침 버튼
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.refresh),
                        ),
                        // 물품 추가 버튼
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .watch(refrigeratorNotifier.notifier)
                                .resetState();
                            ref
                                .watch(refrigeratorNotifier.notifier)
                                .loadContentList(123456789);
                            context.push('/searchContent');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: Colors.amber[300],
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('물품 추가'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 물품 List
              Expanded(
                child:
                    (_group?.groupName ?? '').isEmpty
                        ? const Center(
                          child: Text(
                            "표시 할 냉장고 정보가 없어요. \n '그룹'탭에서 냉장고를 설정해 보세요!",
                            textAlign: TextAlign.center,
                          ),
                        )
                        : ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            _buildContent(_refrigeratorState?.contentList),
                          ],
                        ),
              ),

              if (_refrigeratorState?.isUpdatedContent ?? false)
                _contentUpdateView(),
            ],
          ),
        ],
      ),

      floatingActionButton:
          _refrigeratorState?.isUpdatedContent ?? false
              ? null
              : FloatingActionButton(
                onPressed: () {
                  context.push('/cook');
                },
              ),
    );
  }

  // 보관장소 별 UI 구성
  Widget _buildContent(List<Content>? contentList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          _refrigeratorState?.expContentList?.isNotEmpty ?? false
              ? Column(
                children: <Widget>[
                  const Divider(),
                  ExpansionTile(
                    initiallyExpanded: true,
                    backgroundColor: Colors.red[100],
                    title: const Text(
                      '마감 임박',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: Border.all(color: Colors.transparent),
                    children:
                        _refrigeratorState!.expContentList!
                            .map((Content content) => _buildContentRow(content))
                            .toList(),
                  ),
                  const Divider(),
                  Container(height: 10),
                ],
              )
              : Container(),
          const Divider(),
          ExpansionTile(
            initiallyExpanded: true,
            title: const Text(
              '냉장',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            shape: Border.all(color: Colors.transparent),
            children:
                _refrigeratorState?.refrigeratorContentList != null
                    ? _refrigeratorState!.refrigeratorContentList!.isEmpty
                        ? <Widget>[
                          const Center(
                            child: Text(
                              "냉장고에 보관중인 물품이 없어요.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]
                        : _refrigeratorState!.refrigeratorContentList!
                            .map((Content content) => _buildContentRow(content))
                            .toList()
                    : <Widget>[],
          ),
          const Divider(),
          Container(height: 10),
          const Divider(),
          ExpansionTile(
            initiallyExpanded: true,
            title: const Text(
              '냉동',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            shape: Border.all(color: Colors.transparent),
            children:
                _refrigeratorState?.freezerContentList != null
                    ? _refrigeratorState!.freezerContentList!.isEmpty
                        ? <Widget>[
                          const Center(
                            child: Text(
                              "냉동고에 보관중인 물품이 없어요.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]
                        : _refrigeratorState!.freezerContentList!
                            .map((Content content) => _buildContentRow(content))
                            .toList()
                    : <Widget>[],
          ),
          const Divider(),
        ],
      ),
    );
  }

  // 물품 별 UI 구성
  Widget _buildContentRow(Content content) {
    final Design design = Design(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FutureBuilder(
              future: ref
                  .watch(refrigeratorNotifier.notifier)
                  .loadContent(content.contentId ?? 0),
              builder: (
                BuildContext context,
                AsyncSnapshot<Content?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const AlertDialog(
                    title: Text('데이터를 불러 오는 도중 에러가 발생하였습니다.'),
                  );
                }
                final Content loadContent = snapshot.data!;

                return AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  content: ContentDetailView(content: loadContent),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(
                        '닫기',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    content.contentName,
                    style: const TextStyle(
                      fontSize: Design.normalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '소비기한 ${content.expDate}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            // 수량 조절 버튼
            Row(
              children: <Widget>[
                _quantityButton('-', () {
                  ref
                      .watch(refrigeratorNotifier.notifier)
                      .openUpdateContentCountView();
                  if (content.count > 0) {
                    ref
                        .watch(refrigeratorNotifier.notifier)
                        .reduceContentCount(content.contentId ?? 0);
                  }
                }),
                const SizedBox(width: 5),
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${content.count}',
                    style: const TextStyle(
                      fontSize: Design.normalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                _quantityButton('+', () {
                  ref
                      .watch(refrigeratorNotifier.notifier)
                      .openUpdateContentCountView();
                  ref
                      .watch(refrigeratorNotifier.notifier)
                      .addContentCount(content.contentId ?? 0);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 수량 조절 버튼
  Widget _quantityButton(String symbol, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          symbol,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // 수량 조절 버튼 탭 했을 시 나오는 수량 업데이트 뷰
  Widget _contentUpdateView() {
    Design design = Design(context);
    return Container(
      color: Colors.grey[200],
      height: design.contentUpdateViewHeight,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _refrigeratorState?.updateContentList?.length,
              itemBuilder: (BuildContext context, int index) {
                final Content? content =
                    _refrigeratorState?.updateContentList?[index];
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.only(right: 10),
                  leading: IconButton(
                    onPressed: () {
                      ref
                          .watch(refrigeratorNotifier.notifier)
                          .removeUpdateContentById(content!.contentId ?? 0);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  title: Text(
                    content!.contentName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    content.count.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          _contentUpdateButtons(),
        ],
      ),
    );
  }

  // 수량 업데이트 뷰 버튼
  Widget _contentUpdateButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ref.watch(refrigeratorNotifier.notifier).cancelUpdate();
                ref
                    .watch(refrigeratorNotifier.notifier)
                    .closeUpdateContentCountView();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('전체 취소'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ref
                    .watch(refrigeratorNotifier.notifier)
                    .clearUpdateContentList();
                ref
                    .watch(refrigeratorNotifier.notifier)
                    .removeZeroCountContent();
                ref
                    .watch(refrigeratorNotifier.notifier)
                    .closeUpdateContentCountView();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: Colors.amber[300],
                foregroundColor: Colors.black,
              ),
              child: const Text('물품 개수 반영'),
            ),
          ),
        ],
      ),
    );
  }
}
