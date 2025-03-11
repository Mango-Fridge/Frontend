import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/cook_provider.dart';
import 'cook_view.dart';

class GenerateCookView extends ConsumerStatefulWidget {
  const GenerateCookView({super.key});

  @override
  ConsumerState<GenerateCookView> createState() => _GenerateCookViewState();
}

class _GenerateCookViewState extends ConsumerState<GenerateCookView> {
  // 텍스트 필드 입력을 관리하기 위한 컨트롤러
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();

  // 포커스 노드: 텍스트 필드의 포커스 상태 관리 -> 키보드 상태 관리 목적
  final FocusNode _recipeNameFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // 포커스 상태 변경 리스너 추가
    _recipeNameFocusNode.addListener(() {
      setState(() {
        _isFocused = _recipeNameFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    _recipeNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 포커스 상태에 따른 사이즈 변화 시 애니메이션을 위함
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isFocused ? design.screenWidth * 0.75 : null, // 포커스 시 확장
              child: IntrinsicWidth(
                child: TextField(
                  controller: _recipeNameController,
                  focusNode: _recipeNameFocusNode,
                  decoration: InputDecoration(
                    hintText: '요리 이름 입력',
                    suffixIcon: const Icon(Icons.edit, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 16),
                  onTap: () {
                    // 포커스를 강제로 설정
                    FocusScope.of(context).requestFocus(_recipeNameFocusNode);
                  },
                ),
              ),
            ),

            // 영양성분 표시 box
            if (!_isFocused) ...<Widget>[
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Wrap(
                  spacing: 15.0,
                  children: <Widget>[
                    Column(
                      children: [
                        Text('열량', style: TextStyle(fontSize: 12)),
                        Text('300', style: TextStyle(fontSize: 12)),
                      ],
                    ),

                    Column(
                      children: <Widget>[
                        Text('탄', style: TextStyle(fontSize: 12)),
                        Text('50', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('단', style: TextStyle(fontSize: 12)),
                        Text('20', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('지', style: TextStyle(fontSize: 12)),
                        Text('10', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),

      // 페이지 내용
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // 검색 필드
            TextField(
              decoration: InputDecoration(
                hintText: '냉장고에 있는 음식 재료를 추가해보세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 200),
            Text("재료를 추가해주세요."),
          ],
        ),
      ),

      // 바텀 시트
      bottomSheet: Visibility(
        visible: !_isFocused,
        child: Container(
          color: Colors.amber,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 메모 입력란
              const TextField(
                decoration: InputDecoration(
                  hintText: '요리에 대한 메모를 입력해보세요',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLength: 90,
              ),
              const SizedBox(height: 10),

              // 추가하기 버튼
              ElevatedButton(
                onPressed: () {
                  // 입력값 가져오기
                  final String recipeName = _recipeNameController.text;
                  final String ingredients = _ingredientsController.text;

                  ref.read(recipeNameProvider.notifier).state = recipeName;
                  ref.read(ingredientsProvider.notifier).state = ingredients;
                  Navigator.pop(context); // cook view로 돌아감
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text(
                  '추가하기',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
