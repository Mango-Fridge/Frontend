import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';

class AddCookContentView extends ConsumerStatefulWidget {
  final RefrigeratorItem? item;
  const AddCookContentView({super.key, required this.item});

  @override
  ConsumerState<AddCookContentView> createState() => _AddCookContentViewState();
}

class _AddCookContentViewState extends ConsumerState<AddCookContentView> {
  int contentNumber = 0;

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return SizedBox(
      width: design.screenHeight * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 25,
        children: <Widget>[
          // 제목
          Column(
            spacing: 10,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${widget.item?.itemName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.item?.brandName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: Colors.grey),
            ],
          ),

          // 영양성분 - 칼로리
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: design.screenWidth * 0.63,
                height: design.screenHeight * 0.06,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      "${widget.item?.nutriKcal} kcal",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 영양성분 - 탄단지
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: <Widget>[
              nutrientBox('탄', '${widget.item?.nutriCarbohydrate}'),
              nutrientBox('단', '${widget.item?.nutriProtein}'),
              nutrientBox('지', '${widget.item?.nutriFat}'),
            ],
          ),

          // 수량 조절 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (contentNumber > 0) {
                        contentNumber--;
                      }
                    });
                  },
                  icon: const Icon(Icons.remove, size: 20),
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '$contentNumber',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (contentNumber > 0) {
                        contentNumber++;
                      }
                    });
                  },
                  icon: const Icon(Icons.add, size: 20),
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              actionButton(
                text: '닫기',
                backgroundColor: Colors.white,
                onPressed: () {
                  context.pop();
                },
              ),

              actionButton(
                text: '추가',
                backgroundColor: Colors.amber,
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 영양 성분
  Widget nutrientBox(String label, String value) {
    final Design design = Design(context);
    return SizedBox(
      width: design.screenWidth * 0.19,
      height: design.screenHeight * 0.06,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(label, style: const TextStyle(fontSize: 12)),
              Text('$value g', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  // 닫기 및 추가 버튼
  Widget actionButton({
    required String text,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    final Design design = Design(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: backgroundColor,
        minimumSize: Size(design.screenWidth * 0.32, 40),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }
}
