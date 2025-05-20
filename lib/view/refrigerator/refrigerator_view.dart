import 'dart:async';
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
import 'package:mango/providers/time_ago_provider.dart';
import 'package:mango/state/refrigerator_state.dart';
import 'package:mango/toastMessage.dart';
import 'package:mango/view/login/terms_overlay.dart';
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
    return Stack(
      children: <Widget>[
        Scaffold(
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(design.screenHeight * 0.055),
            child: SafeArea(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: design.marginAndPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Mango",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: Design.appTitleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: design.settingBtnWidth,
                          height: design.settingBtnHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push("/setting");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: design.mainColor,
                            ),
                            child: const Text("⛭ 설정"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: design.marginAndPadding),
                    child: TextButton(
                      onPressed: () {
                        context.push("/group");
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child:
                          _group?.groupName == null
                              ? const SizedBox.shrink()
                              : Text(
                                "${_group?.groupName}의 냉장고 >",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Design.normalFontSize2,
                                ),
                              ),
                    ),
                  ),

                  if ((_group?.groupName ?? '').isNotEmpty)
                    Row(
                      children: <Widget>[
                        buildLastUpdatedText(_refrigeratorState!, ref),
                        IconButton(
                          onPressed: () {
                            (_group?.groupName ?? '').isEmpty
                                ? null
                                : _loadContentList();
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                ],
              ),
              Expanded(
                child:
                    (_group?.groupName ?? '').isEmpty
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: <Widget>[
                            _emptyView(
                              "assets/images/null_home.png",
                              '보유하고 있는 냉장고가 없습니다.',
                              '그룹',
                              '에서 등록/참여해 주세요.',
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                maximumSize: const Size(190, 50),
                              ),
                              onPressed: () => context.push("/group"),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.group),
                                  Text(
                                    '그룹으로 이동',
                                    style: TextStyle(
                                      fontSize: Design.normalFontSize2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: design.homeBottomHeight * 2),
                          ],
                        )
                        : DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: design.marginAndPadding,
                                ),
                                child: const TabBar(
                                  indicatorColor: Colors.amber,
                                  indicatorWeight: 4.0,
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Design.tabBarSelectedFontSize,
                                    fontFamily: 'Mainfonts',
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: Design.tabBarUnSelectedFontSize,
                                    fontFamily: 'Mainfonts',
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: <Widget>[
                                    Tab(text: '냉장'),
                                    Tab(text: '냉동'),
                                  ],
                                ),
                              ),
                              // 물품 List
                              Expanded(
                                child: TabBarView(children: _buildContent()),
                              ),
                              if (_refrigeratorState?.isUpdatedContent ?? false)
                                Column(
                                  children: <Widget>[
                                    _setCountView(),
                                    const SizedBox(height: 50),
                                  ],
                                ),
                            ],
                          ),
                        ),
              ),
            ],
          ),
          // Android / iOS 하단 영역 침범을 방지 하기 위한 용도
          bottomNavigationBar:
              (_group?.groupName ?? "").isEmpty ||
                      _refrigeratorState!.isUpdatedContent
                  ? null
                  : SafeArea(
                    minimum: EdgeInsets.only(bottom: design.marginAndPadding),
                    child: Container(
                      height: design.homeBottomHeight,
                      padding: EdgeInsets.symmetric(
                        horizontal: design.marginAndPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: design.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              onPressed: () {
                                (_group?.groupName ?? '').isEmpty
                                    ? null
                                    : ref
                                        .watch(refrigeratorNotifier.notifier)
                                        .resetState();
                                _loadContentList();
                                context.push('/searchContent');
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: design.homeBottomMarginAndPadding,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: <Widget>[
                                    Icon(Icons.add_shopping_cart),
                                    Text(
                                      "물품 추가",
                                      style: TextStyle(
                                        fontSize: Design.normalFontSize2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: design.cookBtnColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              onPressed: () {
                                context.push('/cook');
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: design.homeBottomMarginAndPadding,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: <Widget>[
                                    Icon(Icons.restaurant),
                                    Text(
                                      "요리",
                                      style: TextStyle(
                                        fontSize: Design.normalFontSize2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
        ),
        _buildTermsOverlay(), // 약관 동의
      ],
    );
  }

  // TermsOverlay 표시 여부를 결정하는 메소드
  Widget _buildTermsOverlay() {
    // 유저가 없으면 화면을 띄우지 않음.
    if (user == null) return const SizedBox.shrink();

    // 유저가 동의를 하지 않았을 때,
    if (!user!.agreePrivacyPolicy!) {
      return const TermsOverlay(
        key: ValueKey('privacyPolicy'),
        termsType: 'privacy policy',
      );
    }
    // 유저가 동의를 하지 않았을 때,
    if (!user!.agreeTermsOfService!) {
      return const TermsOverlay(key: ValueKey('terms'), termsType: 'terms');
    }

    // 유저가 모든 동의를 했을경우, 화면을 띄우지 않음.
    return const SizedBox.shrink();
  }

  // 무엇인가 비었을 때 보여지는 뷰
  Widget _emptyView(
    String imagePath,
    String alertText,
    String tapText,
    String explainText,
  ) {
    final Design design = Design(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: <Widget>[
        Image.asset(imagePath, scale: design.splashImageSize),
        Text(
          alertText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Design.normalFontSize2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tapText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              explainText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  // 유통 기한 마감 임박 항목
  Widget expContentCard({required Content content}) {
    final Design design = Design(context);
    final bool isCntUpdated =
        _refrigeratorState!.updateContentList?.any(
          (Content c) => c.contentId == content.contentId,
        ) ??
        false;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return contentDetailDialog(
              context: dialogContext,
              ref: ref,
              contentId: content.contentId ?? 0,
              design: design,
            );
          },
        );
      },
      child: Container(
        width: 130,
        padding: EdgeInsets.all(design.expContentCardMarginAndPadding),
        decoration: BoxDecoration(
          color:
              isCntUpdated
                  ? design.cntUpdateListColor
                  : ref
                      .watch(refrigeratorNotifier.notifier)
                      .getColorByRemainTime(content.expDate!)
                      .withAlpha(100),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isCntUpdated
                    ? design.cntUpdateListBorderColor
                    : ref
                        .watch(refrigeratorNotifier.notifier)
                        .getColorByRemainTime(content.expDate!),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: ref
                    .watch(refrigeratorNotifier.notifier)
                    .getColorByRemainTime(content.expDate!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                ref
                    .watch(refrigeratorNotifier.notifier)
                    .getRemainDate(content.expDate!),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              content.contentName.length > 8
                  ? '${content.contentName.substring(0, 8)}...'
                  : content.contentName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ref
                    .watch(refrigeratorNotifier.notifier)
                    .getExpiredStatus(content.expDate!)
                ? SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () async {
                      await ref
                          .watch(refrigeratorNotifier.notifier)
                          .setCountZero(_group?.groupId ?? 0, content);

                      ref
                          .watch(refrigeratorNotifier.notifier)
                          .removeZeroCountContent();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: design.cancelColor,
                      side: const BorderSide(color: Colors.red, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "삭제",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
                : contentCounter(
                  count: content.count,
                  contentId: content.contentId!,
                  ref: ref,
                ),
          ],
        ),
      ),
    );
  }

  // 마감 임박 항목 리스트
  Widget horizontalExpContentCards(
    BuildContext context,
    List<Content> contentList,
  ) {
    final Design design = Design(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: contentList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(design.marginAndPadding),
          child: expContentCard(content: contentList[index]),
        );
      },
    );
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
    return _contentSection(
      contentList: _refrigeratorState?.refrigeratorContentList,
      expiringList: _refrigeratorState?.refExpContentList,
    );
  }

  // 냉동실 ContentListView
  Widget _freezerContent() {
    return _contentSection(
      contentList: _refrigeratorState?.freezerContentList,
      expiringList: _refrigeratorState?.frzExpContentList,
    );
  }

  Widget _contentSection({
    required List<Content>? contentList,
    required List<Content>? expiringList,
  }) {
    final Design design = Design(context);
    final int totalCount =
        (contentList?.length ?? 0) + (expiringList?.length ?? 0);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(design.marginAndPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Text('총 $totalCount개 물품'),
                  if (expiringList?.isNotEmpty ?? false)
                    Text(
                      ' (마감 임박 ${expiringList!.length}개)',
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
          if (expiringList?.isNotEmpty ?? false)
            SizedBox(
              height: 160,
              child: horizontalExpContentCards(context, expiringList!),
            ),
          if (contentList?.isNotEmpty ?? false) _listViewBuilder(contentList!),
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
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: _buildContentRow(contentList[index]),
        );
      },
    );
  }

  // 보관장소 별 UI 구성
  List<Widget> _buildContent() {
    final Design design = Design(context);
    return <Widget>[
      _refrigeratorState?.isLoading ?? false
          ? const Center(child: CircularProgressIndicator())
          : _refrigeratorState != null &&
              _refrigeratorState?.refrigeratorContentList != null &&
              (_refrigeratorState!.refrigeratorContentList!.isNotEmpty ||
                  _refrigeratorState!.refExpContentList!.isNotEmpty)
          ? _refrigeratorContent()
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _emptyView(
                "assets/images/null_home.png",
                '냉장고에 아무것도 들어있지 않습니다.',
                '물품 추가',
                '를 통해서 물건을 등록해 주세요.',
              ),
              SizedBox(height: design.homeBottomHeight * 2),
            ],
          ),
      _refrigeratorState?.isLoading ?? false
          ? const Center(child: CircularProgressIndicator())
          : _refrigeratorState != null &&
              _refrigeratorState?.freezerContentList != null &&
              (_refrigeratorState!.freezerContentList!.isNotEmpty ||
                  _refrigeratorState!.frzExpContentList!.isNotEmpty)
          ? _freezerContent()
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _emptyView(
                "assets/images/null_home.png",
                '냉동실에 아무것도 들어있지 않습니다.',
                '물품 추가',
                '를 통해서 물건을 등록해 주세요.',
              ),
              SizedBox(height: design.homeBottomHeight * 2),
            ],
          ),
    ];
  }

  // 물품 별 UI 구성
  Widget _buildContentRow(Content content) {
    final Design design = Design(context);

    final bool isCntUpdated =
        _refrigeratorState!.updateContentList?.any(
          (Content c) => c.contentId == content.contentId,
        ) ??
        false;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return contentDetailDialog(
              context: context,
              ref: ref,
              contentId: content.contentId!,
              design: design,
            );
          },
        );
      },
      child: Container(
        height: 110,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        padding: EdgeInsets.all(design.marginAndPadding),
        decoration: BoxDecoration(
          color:
              isCntUpdated ? design.cntUpdateListColor : Colors.amber.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isCntUpdated
                    ? design.cntUpdateListBorderColor
                    : design.mainColor,
            width: 1.5,
          ),
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
                      fontSize: Design.normalFontSize2,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    (content.brandName?.length ?? 0) > 10
                        ? '${content.brandName?.substring(0, 10)}...'
                        : content.contentName,
                    style: const TextStyle(fontSize: Design.normalFontSize1),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 20,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      ref
                          .watch(refrigeratorNotifier.notifier)
                          .getRemainDate(content.expDate!),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                contentCounter(
                  count: content.count,
                  contentId: content.contentId ?? 0,
                  ref: ref,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 수량 조절 버튼 탭 했을 시 나오는 수량 업데이트 뷰
  Widget _setCountView() {
    Design design = Design(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: design.marginAndPadding - 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.black, width: 1),
          color: design.mainColor.withAlpha(150),
        ),
        height: design.contentUpdateViewHeight,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _refrigeratorState?.updateContentList?.length,
                itemBuilder: (BuildContext context, int index) {
                  final Content? content =
                      _refrigeratorState?.updateContentList?[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: design.marginAndPadding + 5,
                      right: design.marginAndPadding + 5,
                      top: design.marginAndPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              ref
                                  .watch(refrigeratorNotifier.notifier)
                                  .removeUpdateContentById(
                                    content!.contentId ?? 0,
                                  );
                            },
                            splashColor: Colors.grey.shade200,
                            highlightColor: Colors.grey.shade200,
                            child: Container(
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
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            content!.contentName,
                            style: const TextStyle(
                              fontSize: Design.normalFontSize1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          content.count.toString(),
                          style: TextStyle(
                            fontSize: Design.normalFontSize1,
                            fontWeight: FontWeight.bold,
                            color: content.count > 0 ? Colors.blue : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _setCountButtons(),
          ],
        ),
      ),
    );
  }

  Widget contentCounter({
    required int count,
    required int contentId,
    required WidgetRef ref,
  }) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 110,
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1.5),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      ref
                          .watch(refrigeratorNotifier.notifier)
                          .openUpdateContentCountView();
                      if (count > 0) {
                        ref
                            .watch(refrigeratorNotifier.notifier)
                            .reduceContentCount(contentId);
                      }
                    },
                    splashColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Text('$count개'),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      ref
                          .watch(refrigeratorNotifier.notifier)
                          .openUpdateContentCountView();
                      ref
                          .watch(refrigeratorNotifier.notifier)
                          .addContentCount(contentId);
                    },
                    splashColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade200,
                    child: const Icon(Icons.add, size: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
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
            child: OutlinedButton(
              onPressed: () {
                ref.watch(refrigeratorNotifier.notifier).cancelUpdate();
                ref
                    .watch(refrigeratorNotifier.notifier)
                    .closeUpdateContentCountView();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: Colors.red.shade100,
                side: const BorderSide(color: Colors.red, width: 2),
              ),
              child: const Text('전체 취소', style: TextStyle(color: Colors.red)),
            ),
          ),
          Expanded(
            child: OutlinedButton(
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
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.amber[300],
                side: const BorderSide(color: Colors.amber, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('물품 개수 반영'),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentDetailDialog({
    required BuildContext context,
    required WidgetRef ref,
    required int contentId,
    required Design design,
  }) {
    return FutureBuilder(
      future: ref.watch(refrigeratorNotifier.notifier).loadContent(contentId),
      builder: (BuildContext context, AsyncSnapshot<Content?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const AlertDialog(title: Text('데이터를 불러 오는 도중 에러가 발생하였습니다.'));
        }
        final Content loadedContent = snapshot.data!;

        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: design.subColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: SizedBox(
            width: design.termsOverlayWidth * 0.85,
            child: ContentDetailView(content: loadedContent),
          ),
        );
      },
    );
  }

  Widget buildLastUpdatedText(RefrigeratorState state, WidgetRef ref) {
    final DateTime? updatedTime = state.lastUpdatedTime;
    if (updatedTime == null) {
      return const Text(
        "방금 전",
        style: TextStyle(fontSize: Design.normalFontSize1),
      );
    }

    final String text = ref.watch(timeAgoNotifierProvider(updatedTime));
    return Text(
      text,
      style: const TextStyle(
        fontSize: Design.normalFontSize1,
        fontWeight: FontWeight.bold,
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
