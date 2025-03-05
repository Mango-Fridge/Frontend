import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';

class SearchContentView extends ConsumerStatefulWidget {
  const SearchContentView({super.key});
  @override
  ConsumerState<SearchContentView> createState() => _SearchContentViewState();
}

class _SearchContentViewState extends ConsumerState<SearchContentView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Design design = Design(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("물품 추가"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        spacing: 20,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: design.screenWidth * 0.035,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: design.screenWidth * 0.035,
            ),
            decoration: BoxDecoration(
              color: Colors.amber[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "ex) 초코칩",
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                // 값이 변경 될 때마다 api 호출 해야 함. (ItemRepository 및 ItemList를 관리해주는 Provider 구현 필요)
                // 호출 결과에 따라 ListView인지 예외 처리인지 구분
                print(value);
                setState(() {});
              },
            ),
          ),
          // SizedBox 부터 Spacer 까지는 api 호출 결과에 따라 노출/비노출
          const SizedBox(height: 100),
          Image.asset(
            "assets/images/cart.png",
            width: design.cartImageSize,
            height: design.cartImageSize,
          ),
          const Text(
            "찾고 싶은 물품을 검색하거나,\n원하는 물품이 없다면 직접 추가해 보세요!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () {
              context.push('/addContent');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[300],
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("직접 물품 추가"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
