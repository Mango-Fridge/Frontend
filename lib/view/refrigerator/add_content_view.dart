import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:intl/intl.dart';

class AddContentView extends ConsumerStatefulWidget {
  const AddContentView({super.key});
  @override
  ConsumerState<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends ConsumerState<AddContentView> {
  String category = '아이스크림';
  String storage = '냉장';
  int quantity = 0;
  String memo = '';

  DateTime registerDate = DateTime.now();
  DateTime? expirationDate;

  bool showNutrition = false;

  final TextEditingController capacityController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  bool get isNutritionEmpty {
    return capacityController.text.isEmpty ||
        caloriesController.text.isEmpty ||
        carbsController.text.isEmpty ||
        proteinController.text.isEmpty ||
        fatController.text.isEmpty;
  }

  Future<void> _selectDateTime(
    BuildContext context,
    bool isRegisterDate,
  ) async {
    // 날짜 선택
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isRegisterDate ? registerDate : (expirationDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ko', 'KR'),
    );

    if (pickedDate != null) {
      // 시간 선택
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          isRegisterDate ? registerDate : (expirationDate ?? DateTime.now()),
        ),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isRegisterDate) {
            registerDate = combinedDateTime;
          } else {
            expirationDate = combinedDateTime;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Design design = Design(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('물품 추가 상세 입력'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: design.screenWidth * 0.035),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const TextField(
                style: TextStyle(fontSize: 22.0),
                decoration: InputDecoration(hintText: '물품 명을 입력해 주세요'),
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  SizedBox(
                    width: design.screenWidth * 0.22,
                    child: const Row(
                      children: <Widget>[
                        Text('카테고리 '),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),

                  Expanded(
                    child: DropdownButton<String>(
                      value: category,
                      isExpanded: true,
                      items:
                          <String>['수제쿠키', '아이스크림', '육류'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  SizedBox(
                    width: design.screenWidth * 0.22,
                    child: const Row(
                      children: <Widget>[
                        Text('수량 (인분) '),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(
                        text: quantity.toString(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  SizedBox(
                    width: design.screenWidth * 0.22,
                    child: const Row(
                      children: <Widget>[
                        Text('등록 날짜 '),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat(
                        'a yyyy년 M월 d일 h시 mm분',
                        'ko',
                      ).format(registerDate),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDateTime(context, true),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  SizedBox(
                    width: design.screenWidth * 0.22,
                    child: const Row(
                      children: <Widget>[
                        Text('소비 기한 '),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Text(
                      expirationDate == null
                          ? '선택하세요'
                          : DateFormat(
                            'a yyyy년 M월 d일 h시 mm분',
                            'ko',
                          ).format(expirationDate!),
                      style: TextStyle(
                        color:
                            expirationDate == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDateTime(context, false),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  SizedBox(
                    width: design.screenWidth * 0.22,
                    child: const Row(
                      children: <Widget>[
                        Text('보관 장소 '),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: storage,
                      isExpanded: true,
                      items:
                          <String>['냉장', '냉동'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          storage = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              Row(
                spacing: 10,
                children: <Widget>[
                  SizedBox(
                    width: design.screenWidth * 0.22,
                    child: const Text('메모'),
                  ),

                  Expanded(
                    child: TextField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '메모를 입력하세요',
                      ),
                      onChanged: (text) {
                        setState(() {
                          memo = text;
                        });
                      },
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('영양 성분', style: TextStyle(fontSize: 14)),
                    IconButton(
                      icon: const Icon(Icons.help_outline),
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       title: const Text('영양 성분 입력 안내'),
                        //       content: const Text(
                        //         "각 영양 성분을 입력해야 '물품 공개 등록' 버튼을 활성화할 수 있습니다.",
                        //       ),
                        //       actions: <Widget>[
                        //         TextButton(
                        //           onPressed: () => Navigator.pop(context),
                        //           child: const Text('확인'),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
                      },
                    ),
                  ],
                ),
                children: <Widget>[
                  Column(
                    spacing: 10,
                    children: <Widget>[
                      Row(
                        spacing: 10,
                        children: <Widget>[
                          SizedBox(
                            width: design.screenWidth * 0.22,
                            child: const Text('단위'),
                          ),
                          Expanded(
                            child: TextField(
                              controller: capacityController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'ex) 150',
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                          buildElevatedButton(
                            label: 'g',
                            onPressed: () {},
                            backgroundColor: Colors.amber[300]!,
                            foregroundColor: Colors.black,
                          ),
                          buildElevatedButton(
                            label: 'ml',
                            onPressed: () {},
                            backgroundColor: Colors.amber[300]!,
                            foregroundColor: Colors.black,
                          ),
                        ],
                      ),
                      nutritionInputRow(
                        label: '열량',
                        controller: caloriesController,
                        hintText: 'ex) 150',
                        onChanged: () {},
                      ),
                      nutritionInputRow(
                        label: '탄수화물',
                        controller: carbsController,
                        hintText: 'ex) 50',
                        onChanged: () {},
                      ),
                      nutritionInputRow(
                        label: '단백질',
                        controller: proteinController,
                        hintText: 'ex) 150',
                        onChanged: () {},
                      ),
                      nutritionInputRow(
                        label: '지방',
                        controller: fatController,
                        hintText: 'ex) 150',
                        onChanged: () {},
                      ),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  Expanded(
                    child: buildElevatedButton(
                      label: '물품 공개 등록',
                      onPressed: isNutritionEmpty ? null : () {},
                      backgroundColor: Colors.amber[200]!,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: buildElevatedButton(
                      label: '물품 등록',
                      onPressed: () {},
                      backgroundColor: Colors.amber[300]!,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget nutritionInputRow({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onChanged,
  }) {
    return Row(
      spacing: 10,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          child: Text(label),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
            onChanged: (_) {},
          ),
        ),
      ],
    );
  }

  Widget buildElevatedButton({
    required String label,
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(label, style: TextStyle(color: foregroundColor)),
    );
  }
}
