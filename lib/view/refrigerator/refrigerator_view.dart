import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/refrigerator_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/state/refrigerator_state.dart';
import 'package:mango/toastMessage.dart';
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

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(refrigeratorNotifier.notifier).resetState();
      await ref.read(groupProvider.notifier).loadGroup(user?.usrId ?? 0);

      _loadContentList();
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
        toolbarHeight: design.screenHeight * 0.08,
        leading: Padding(
          padding: EdgeInsets.all(design.marginAndPadding),
          child: Row(
            children: <Widget>[
              Container(),
              Image.asset(
                "assets/images/title.png",
                width: design.homeImageSize,
              ),
              const Text(
                "Mango",
                style: TextStyle(
                  fontSize: Design.appTitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // 새로고침 버튼
              if ((_group?.groupName ?? '').isNotEmpty)
                IconButton(
                  onPressed: () {
                    (_group?.groupName ?? '').isEmpty
                        ? null
                        : _loadContentList();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              // 물품 추가 버튼
              if ((_group?.groupName ?? '').isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    (_group?.groupName ?? '').isEmpty
                        ? null
                        : ref.watch(refrigeratorNotifier.notifier).resetState();
                    _loadContentList();
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
        ),
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(design.marginAndPadding),
              child: const TabBar(
                indicatorColor: Colors.amber,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Design.tabBarFontSize,
                ),
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: <Widget>[
                  //Tab(text: '유통 기한 임박'),
                  Tab(text: '냉장'),
                  Tab(text: '냉동'),
                ],
              ),
            ),

            // 물품 List
            Expanded(
              child: TabBarView(
                children:
                    (_group?.groupName ?? '').isEmpty
                        ? _noGroupView()
                        : _buildContent(),
              ),
            ),
            if (_refrigeratorState?.isUpdatedContent ?? false) _setCountView(),
          ],
        ),
      ),
      floatingActionButton:
          (_group?.groupName ?? "").isEmpty ||
                  _refrigeratorState!.isUpdatedContent
              ? null
              : FloatingActionButton(
                onPressed: () {
                  context.push('/cook');
                },
              ),
    );
  }

  // 속한 그룹이 없을 때 보여지는 뷰
  List<Widget> _noGroupView() {
    return List.generate(
      2,
      (_) => const Center(
        child: Text(
          "표시 할 냉장고 정보가 없어요. \n '그룹'탭에서 냉장고를 설정해 보세요!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // ContentList가 비었을 때 보여지는 뷰
  Widget _noContentView(String text) {
    return Center(child: Text(text, textAlign: TextAlign.center));
  }

  Widget contentExpansionTile(
    BuildContext context,
    String title,
    List<Content> contentList,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            color: title == '유통 기한 마감 임박' ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        initiallyExpanded: true,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contentList.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildContentRow(contentList[index]);
            },
          ),
        ],
      ),
    );
  }

  // 냉장고 ContentListView
  Widget _refrigeratorContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (_refrigeratorState?.refExpContentList?.isNotEmpty ??
              false) ...<Widget>[
            contentExpansionTile(
              context,
              '유통 기한 마감 임박',
              _refrigeratorState!.refExpContentList!,
            ),
            const Divider(),
          ],

          if (_refrigeratorState?.refrigeratorContentList?.isNotEmpty ?? false)
            _listViewBuilder(_refrigeratorState!.refrigeratorContentList!),
        ],
      ),
    );
  }

  // 냉동실 ContentListView
  Widget _freezerContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (_refrigeratorState?.frzExpContentList?.isNotEmpty ??
              false) ...<Widget>[
            contentExpansionTile(
              context,
              '유통 기한 마감 임박',
              _refrigeratorState!.frzExpContentList!,
            ),

            const Divider(),
          ],

          if (_refrigeratorState?.freezerContentList?.isNotEmpty ?? false)
            _listViewBuilder(_refrigeratorState!.freezerContentList!),
        ],
      ),
    );
  }

  Widget _listViewBuilder(List<Content> contentList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contentList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildContentRow(contentList[index]);
      },
    );
  }

  // 보관장소 별 UI 구성
  List<Widget> _buildContent() {
    return <Widget>[
      _refrigeratorState?.isLoading ?? false
          ? const Center(child: CircularProgressIndicator())
          : _refrigeratorState != null &&
              _refrigeratorState?.refrigeratorContentList != null &&
              (_refrigeratorState!.refrigeratorContentList!.isNotEmpty ||
                  _refrigeratorState!.refExpContentList!.isNotEmpty)
          ? _refrigeratorContent()
          : _noContentView('냉장고에 보관중인 물품이 없어요.'),
      _refrigeratorState?.isLoading ?? false
          ? const Center(child: CircularProgressIndicator())
          : _refrigeratorState != null &&
              _refrigeratorState?.freezerContentList != null &&
              (_refrigeratorState!.freezerContentList!.isNotEmpty ||
                  _refrigeratorState!.frzExpContentList!.isNotEmpty)
          ? _freezerContent()
          : _noContentView('냉동실에 보관중인 물품이 없어요.'),
    ];
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
                final Content loadedContent = snapshot.data!;

                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  content: SizedBox(
                    width: design.termsOverlayWidth * 0.85,
                    height: design.termsOverlayHeight * 0.90,
                    child: ContentDetailView(content: loadedContent),
                  ),
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
          color:
              (DateTime.now().difference(content.expDate!).inHours > -24)
                  ? Colors.red[200]
                  : Colors.amber[300],
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
                    content.contentName.length > 10
                        ? '${content.contentName.substring(0, 10)}...'
                        : content.contentName,
                    style: const TextStyle(
                      fontSize: Design.normalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '소비기한: ${DateFormat('yyyy-M-d a h:m:s', 'ko').format(content.expDate ?? DateTime.now())}',
                    style: const TextStyle(
                      fontSize: Design.contentRowExpFontSize,
                    ),
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
                  width: design.screenWidth * 0.17,
                  height: design.screenWidth * 0.080,
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
    final Design design = Design(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: design.screenWidth * 0.080,
        height: design.screenWidth * 0.080,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          symbol,
          style: const TextStyle(
            fontSize: Design.countButtonFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 수량 조절 버튼 탭 했을 시 나오는 수량 업데이트 뷰
  Widget _setCountView() {
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
                      fontSize: Design.setCountViewFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    content.count.toString(),
                    style: const TextStyle(
                      fontSize: Design.setCountViewFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          _setCountButtons(),
        ],
      ),
    );
  }

  // 수량 업데이트 뷰 버튼
  Widget _setCountButtons() {
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
              onPressed: () async {
                await ref
                    .watch(refrigeratorNotifier.notifier)
                    .setCount(
                      _group?.groupId ?? 0,
                      _refrigeratorState?.updateContentList ?? <Content>[],
                    );

                toastMessage(
                  context,
                  _refrigeratorState?.setCountMessage ?? '',
                );

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

  void _loadContentList() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    ref.read(refrigeratorNotifier.notifier).setLoading(true);

    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref
          .read(refrigeratorNotifier.notifier)
          .loadContentList(_group?.groupId ?? 0);
    });
  }
}
