import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/group.dart';
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
  List<Group>? get _groupList => ref.watch(groupProvider);
  RefrigeratorState? get _refrigeratorState => ref.watch(refrigeratorNotifier);

  String? _selectedGroup; // 선택 된 그룹
  String? _selectedGroupId; // 선택 된 그룹 Id

  // initState()로 watch하니까 자꾸 에러나서 찾아보니 initState 후에 호출되는 함수라고 하여 사용.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ref.watch(groupProvider.notifier).loadGroupList('example@example.com');
    ref.watch(refrigeratorNotifier.notifier).loadContentList('groupId');
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leadingWidth: double.infinity,
          leading: Row(
            spacing: 15,
            children: <Widget>[
              Container(),
              Image.asset(
                "assets/images/title.png",
                width: design.homeImageSize,
              ),
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
                      // 그룹 콤보 박스
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            _selectedGroupId = value;
                            _selectedGroup =
                                _groupList!
                                    .firstWhere(
                                      (Group group) => group.groupId == value,
                                    )
                                    .groupName;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return _groupList!.map<PopupMenuEntry<String>>((
                            Group group,
                          ) {
                            return PopupMenuItem<String>(
                              value: group.groupId,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                child: Text(group.groupName),
                              ),
                            );
                          }).toList();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber[300],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(_selectedGroup ?? '그룹을 선택 해 주세요.'),
                        ),
                      ),
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
                      _groupList!.isEmpty
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
          const Divider(),
          ExpansionTile(
            title: const Text(
              '냉장',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            shape: Border.all(color: Colors.transparent),
            children:
                contentList!
                        .where((Content content) => content.storageArea == '냉장')
                        .isEmpty
                    ? <Widget>[
                      const Center(
                        child: Text(
                          "냉장고에 보관중인 물품이 없어요.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]
                    : contentList
                        .where((Content content) => content.storageArea == '냉장')
                        .map((Content content) => _buildContentRow(content))
                        .toList(),
          ),
          const Divider(),
          Container(height: 10),
          const Divider(),
          ExpansionTile(
            title: const Text(
              '냉동',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            shape: Border.all(color: Colors.transparent),
            children:
                contentList
                        .where((Content content) => content.storageArea == '냉동')
                        .isEmpty
                    ? <Widget>[
                      const Center(
                        child: Text(
                          "냉동고에 보관중인 물품이 없어요.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]
                    : contentList
                        .where((Content content) => content.storageArea == '냉동')
                        .map((Content content) => _buildContentRow(content))
                        .toList(),
          ),
          const Divider(),
        ],
      ),
    );
  }

  // 물품 별 UI 구성
  Widget _buildContentRow(Content content) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              content: ContentDetailView(content: content),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(8),
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
                      fontSize: 16,
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
                        .reduceContentCount(content.contentId);
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
                      fontSize: 16,
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
                      .addContentCount(content.contentId);
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

  Widget _contentUpdateView() {
    Design design = Design(context);
    return Container(
      color: Colors.grey[200],
      height: design.screenHeight * 0.20,
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
                          .removeUpdateContentById(content!.contentId);
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
