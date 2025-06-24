import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/state/add_cook_state.dart';

class AddCookContentView extends ConsumerStatefulWidget {
  final RefrigeratorItem? item;
  final VoidCallback? onConfirmed; // 검색 필드에서 물품 클릭하고, 확인 버튼 눌렀을 때 실행하기 위함 콜백

  const AddCookContentView({super.key, required this.item, this.onConfirmed});

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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    (widget.item?.itemName ?? '').length > 25
                        ? '${(widget.item?.itemName ?? '').substring(0, 25)}...'
                        : widget.item?.itemName ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    (widget.item?.brandName ?? '').length > 20
                        ? '${(widget.item?.brandName ?? '').substring(0, 5)}...'
                        : widget.item?.brandName ?? '',
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              // const Divider(thickness: 1, color: Colors.grey),
            ],
          ),

          // 영양성분 - 탄단지
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.amber, // Yellow border
                width: 1.0, // Border thickness
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: <Widget>[
                nutrientBox('열량', '${getItemTotalKcal()}', Colors.black),
                nutrientBox(
                  '탄수화물',
                  '${getItemTotalCarbohydrate()}',
                  Colors.green,
                ),
                nutrientBox('단백질', '${getItemTotalProtein()}', Colors.amber),
                nutrientBox(
                  '지방',
                  '${getItemTotalFat()}',
                  const Color.fromARGB(255, 155, 118, 5),
                ),
              ],
            ),
          ),

          // 수량 조절 버튼
          Column(
            spacing: 10,
            children: [
              const Text(
                '선택된 수량',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: <Widget>[
                  // 감소 버튼
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        ref.watch(addCookProvider.notifier).reduceItemCount();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          252,
                          117,
                          117,
                        ),
                        foregroundColor: Colors.redAccent,
                        side: BorderSide(color: Colors.redAccent, width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ), // Rounded corners
                        ),
                        minimumSize: const Size(50, 50), // Square button size
                        padding: const EdgeInsets.all(
                          8.0,
                        ), // Consistent with original padding
                      ),
                      child: const Icon(Icons.remove, size: 20),
                    ),
                  ),

                  // 수량
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.amber, // Yellow border
                        width: 1.0, // Border thickness
                      ),
                    ),
                    child: Text(
                      '${_addCookState?.itemCount}',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),

                  // 추가 버튼
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        ref.watch(addCookProvider.notifier).addItemCount();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          118,
                          168,
                          255,
                        ),
                        foregroundColor: Colors.blueAccent,
                        side: BorderSide(color: Colors.blueAccent, width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ), // Rounded corners
                        ),
                        minimumSize: const Size(50, 50), // Square button size
                        padding: const EdgeInsets.all(
                          8.0,
                        ), // Consistent with original padding
                      ),
                      child: const Icon(Icons.add, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: Text('닫기', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(255, 233, 175, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(100, 40),
                ),
                onPressed: () {
                  context.pop();
                },
              ),

              ElevatedButton(
                child: Text('추가', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(100, 40),
                ),
                onPressed: () {
                  context.pop();
                  ref.watch(addCookProvider.notifier).addCookItem(widget.item!);
                  ref.watch(addCookProvider.notifier).sumKcal();
                  ref.watch(addCookProvider.notifier).sumCarb();
                  ref.watch(addCookProvider.notifier).sumProtein();
                  ref.watch(addCookProvider.notifier).sumFat();
                  widget.onConfirmed?.call(); // 콜백 실행
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 영양 성분
  Widget nutrientBox(String label, String value, Color color) {
    final Design design = Design(context);
    final String displayValue = label == '열량' ? '${value}kcal' : value;
    return SizedBox(
      width: design.screenWidth * 0.14,
      height: design.screenHeight * 0.07, // 여기서 뷰 크기 조절
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                displayValue,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
