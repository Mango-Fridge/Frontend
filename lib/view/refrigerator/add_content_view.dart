import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContentView extends ConsumerStatefulWidget {
  const AddContentView({super.key});
  @override
  ConsumerState<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends ConsumerState<AddContentView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            margin: const EdgeInsets.all(16), // 나중에 변경
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                print(value);
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 100),
          Image.asset("assets/images/cart.png", width: 120, height: 120),
          const Text(
            "찾고 싶은 물품을 검색하거나,\n원하는 물품이 없다면 직접 추가해 보세요!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () {
              // 직접 추가 로직
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[300],
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
