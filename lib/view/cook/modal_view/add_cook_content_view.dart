import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/state/add_cook_state.dart';

class AddCookContentView extends ConsumerStatefulWidget {
  final RefrigeratorItem? item;

  const AddCookContentView({super.key, required this.item});

  @override
  ConsumerState<AddCookContentView> createState() => _AddCookContentViewState();
}

class _AddCookContentViewState extends ConsumerState<AddCookContentView> {
  AddCookState? get _addCookState => ref.watch(addCookProvider);

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    int getItemTotalKcal() {
      if (_addCookState == null) return 0;
      return (widget.item?.nutriKcal ?? 0) * _addCookState!.itemCount;
    }

    int getItemTotalCarbohydrate() {
      if (_addCookState == null) return 0;
      return (widget.item?.nutriCarbohydrate ?? 0) * _addCookState!.itemCount;
    }

    int getItemTotalProtein() {
      if (_addCookState == null) return 0;
      return (widget.item?.nutriProtein ?? 0) * _addCookState!.itemCount;
    }

    int getItemTotalFat() {
      if (_addCookState == null) return 0;
      return (widget.item?.nutriFat ?? 0) * _addCookState!.itemCount;
    }

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
                    (widget.item?.itemName ?? '').length > 10
                        ? '${(widget.item?.itemName ?? '').substring(0, 10)}...'
                        : widget.item?.itemName ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    (widget.item?.brandName ?? '').length > 5
                        ? '${(widget.item?.brandName ?? '').substring(0, 5)}...'
                        : widget.item?.brandName ?? '',
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
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
                      "${getItemTotalKcal()} kcal",
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
              nutrientBox('탄', '${getItemTotalCarbohydrate()}'),
              nutrientBox('단', '${getItemTotalProtein()}'),
              nutrientBox('지', '${getItemTotalFat()}'),
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
                    ref.watch(addCookProvider.notifier).reduceItemCount();
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
                  '${_addCookState?.itemCount}',
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
                    ref.watch(addCookProvider.notifier).addItemCount();
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
                  ref.watch(addCookProvider.notifier).addCookItem(widget.item!);
                  ref.watch(addCookProvider.notifier).sumKcal();
                  ref.watch(addCookProvider.notifier).sumCarb();
                  ref.watch(addCookProvider.notifier).sumProtein();
                  ref.watch(addCookProvider.notifier).sumFat();
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
