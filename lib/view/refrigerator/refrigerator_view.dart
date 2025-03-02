import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/content_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';

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
  List<Content>? get _contentList => ref.watch(contentProvider);

  String? _selectedGroup; // 선택 된 그룹
  String? _selectedGroupId; // 선택 된 그룹 Id

  // initState()로 watch하니까 자꾸 에러나서 찾아보니 initState 후에 호출되는 함수라고 하여 사용.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ref.watch(groupProvider.notifier).loadGroupList('example@example.com');
    ref.watch(contentProvider.notifier).loadContentList('groupId');
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
                            onPressed: () {},
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
                            children: <Widget>[_buildContent(_contentList)],
                          ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
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
                    .map((Content content) => _buildItemRow(content))
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
                contentList!
                    .where((Content content) => content.storageArea == '냉동')
                    .map((Content content) => _buildItemRow(content))
                    .toList(),
          ),
          const Divider(),
        ],
      ),
    );
  }

  // 물품 별 UI 구성
  Widget _buildItemRow(Content content) {
    return Container(
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
                    .watch(contentProvider.notifier)
                    .subContentCount(content.contentId);
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
                    .watch(contentProvider.notifier)
                    .addContentCount(content.contentId);
              }),
            ],
          ),
        ],
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
}
