import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:intl/intl.dart';
import 'package:mango/providers/add_content_provider.dart';
import 'package:mango/state/add_content_state.dart';

class AddContentView extends ConsumerStatefulWidget {
  const AddContentView({super.key});
  @override
  ConsumerState<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends ConsumerState<AddContentView> {
  List<String> contentCategory = <String>['육류', '음료류', '채소류', '과자류', '아이스크림류'];
  List<String> contentStorage = <String>['냉장', '냉동'];

  AddContentState? get _addContentState => ref.watch(addContentProvider);

  static const int _memoMaxLine = 3;
  static const int _memoMaxLength = 120;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController(
    text: '1',
  );
  final TextEditingController memoController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(addContentProvider.notifier).resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    Design design = Design(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('물품 추가 상세 입력'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: design.marginAndPadding),
          child: Column(
            spacing: 20,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  // Content detail info view
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: nameController,
                        style: const TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: '물품 명을 입력해 주세요',
                          hintStyle: TextStyle(color: Colors.red[200]),
                          errorText:
                              _addContentState
                                          ?.contentNameErrorMessage
                                          ?.isEmpty ??
                                      true
                                  ? null
                                  : _addContentState?.contentNameErrorMessage,
                        ),
                        onChanged: (String value) {
                          ref
                              .watch(addContentProvider.notifier)
                              .updateNameErrorMessage(value);
                        },
                      ),
                      Row(
                        spacing: 10,
                        children: <Widget>[
                          SizedBox(
                            width: design.screenWidth * 0.22,
                            child: const Row(
                              children: <Widget>[
                                Text(
                                  '카테고리 ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value:
                                  _addContentState?.selectedContentCategory ??
                                  contentCategory[0],
                              isExpanded: true,
                              items:
                                  contentCategory.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                ref
                                    .watch(addContentProvider.notifier)
                                    .setCategory(newValue ?? '');
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
                                Text(
                                  '수량 (인분) ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: countController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                errorText:
                                    _addContentState
                                                ?.contentCountErrorMessage
                                                ?.isEmpty ??
                                            true
                                        ? null
                                        : _addContentState
                                            ?.contentCountErrorMessage,
                              ),
                              onChanged: (String value) {
                                ref
                                    .watch(addContentProvider.notifier)
                                    .updateCount(value);
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
                                Text(
                                  '등록 날짜 ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              DateFormat('yyyy년 M월 d일 a h시 m분', 'ko').format(
                                _addContentState?.selectedRegDate ??
                                    DateTime.now(),
                              ),
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
                                Text(
                                  '소비 기한 ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Text(
                              _addContentState?.selectedExpDate == null
                                  ? '날짜를 선택하세요'
                                  : DateFormat(
                                    'yyyy년 M월 d일 a h시 m분',
                                    'ko',
                                  ).format(
                                    _addContentState!.selectedExpDate ??
                                        DateTime.now(),
                                  ),
                              style: TextStyle(
                                color:
                                    _addContentState?.selectedExpDate == null
                                        ? Colors.red[300]
                                        : Colors.black,
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
                                Text(
                                  '보관 장소 ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value:
                                  _addContentState?.selectedContentStorage ??
                                  contentStorage[0],
                              isExpanded: true,
                              items:
                                  contentStorage.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                ref
                                    .watch(addContentProvider.notifier)
                                    .setStorage(newValue ?? '');
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
                            child: const Text(
                              '메모',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  controller: memoController,
                                  maxLines: _memoMaxLine,
                                  maxLength: _memoMaxLength,
                                  decoration: const InputDecoration(
                                    hintText: "메모를 입력하세요",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // nutrition view
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: const Row(
                          spacing: 10,
                          children: <Widget>[
                            Text(
                              '영양 성분',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Tooltip(
                              triggerMode: TooltipTriggerMode.tap,
                              message:
                                  "각 영양 성분을 입력해야 \n'물품 공개 등록' 버튼을 \n활성화할 수 있습니다.",
                              child: Icon(Icons.help_outline),
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
                                    child: const Text(
                                      '단위',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: capacityController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'ex) 150',
                                      ),
                                      onChanged: (String? newValue) {
                                        ref
                                            .read(addContentProvider.notifier)
                                            .updateCapacity(
                                              capacityController.text,
                                            );
                                      },
                                    ),
                                  ),
                                  buildElevatedButton(
                                    label: 'g',
                                    onPressed: () {
                                      ref
                                          .watch(addContentProvider.notifier)
                                          .setUnit('g');
                                    },
                                    backgroundColor: Colors.amber[300]!,
                                    foregroundColor: Colors.black,
                                    borderColor:
                                        _addContentState?.selectedUnit == 'g'
                                            ? Colors.red
                                            : Colors.transparent,
                                  ),
                                  buildElevatedButton(
                                    label: 'ml',
                                    onPressed: () {
                                      ref
                                          .watch(addContentProvider.notifier)
                                          .setUnit('ml');
                                    },
                                    backgroundColor: Colors.amber[300]!,
                                    foregroundColor: Colors.black,
                                    borderColor:
                                        _addContentState?.selectedUnit == 'ml'
                                            ? Colors.red
                                            : Colors.transparent,
                                  ),
                                ],
                              ),
                              nutritionInputRow(
                                label: '열량',
                                controller: caloriesController,
                                hintText: 'ex) 150',
                                onChanged: () {
                                  ref
                                      .read(addContentProvider.notifier)
                                      .updateCalories(caloriesController.text);
                                },
                              ),
                              nutritionInputRow(
                                label: '탄수화물',
                                controller: carbsController,
                                hintText: 'ex) 50',
                                onChanged: () {
                                  ref
                                      .read(addContentProvider.notifier)
                                      .updateCarbs(carbsController.text);
                                },
                              ),
                              nutritionInputRow(
                                label: '단백질',
                                controller: proteinController,
                                hintText: 'ex) 150',
                                onChanged: () {
                                  ref
                                      .read(addContentProvider.notifier)
                                      .updateProtein(proteinController.text);
                                },
                              ),
                              nutritionInputRow(
                                label: '지방',
                                controller: fatController,
                                hintText: 'ex) 150',
                                onChanged: () {
                                  ref
                                      .read(addContentProvider.notifier)
                                      .updateFat(fatController.text);
                                },
                              ),
                              const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Submit Buttons
              Row(
                spacing: 10,
                children: <Widget>[
                  Expanded(
                    child: buildElevatedButton(
                      label: '물품 공개 등록',
                      onPressed:
                          _addContentState?.isNutritionEmpty ?? false
                              ? () {
                                print('test');
                              }
                              : null,
                      backgroundColor: Colors.amber[200]!,
                      foregroundColor: Colors.black,
                      borderColor: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: buildElevatedButton(
                      label: '물품 등록',
                      onPressed:
                          _addContentState?.isDetailInfoEmpty ?? false
                              ? () {
                                ref
                                    .watch(addContentProvider.notifier)
                                    .saveContent(
                                      nameController.text,
                                      _addContentState
                                              ?.selectedContentCategory ??
                                          contentCategory[0],
                                      int.parse(countController.text),
                                      _addContentState?.selectedRegDate ??
                                          DateTime.now(),
                                      _addContentState?.selectedRegDate ??
                                          DateTime.now(),
                                      _addContentState
                                              ?.selectedContentStorage ??
                                          contentStorage[0],
                                      memoController.text,
                                      '',
                                      capacityController.text.isNotEmpty
                                          ? int.parse(capacityController.text)
                                          : 0,
                                      caloriesController.text.isNotEmpty
                                          ? int.parse(caloriesController.text)
                                          : 0,
                                      carbsController.text.isNotEmpty
                                          ? int.parse(carbsController.text)
                                          : 0,
                                      proteinController.text.isNotEmpty
                                          ? int.parse(proteinController.text)
                                          : 0,
                                      fatController.text.isNotEmpty
                                          ? int.parse(fatController.text)
                                          : 0,
                                    );
                              }
                              : null,
                      backgroundColor: Colors.amber[300]!,
                      foregroundColor: Colors.black,
                      borderColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged();
              }
            },
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
    required Color borderColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: borderColor, width: 2.0),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(label, style: TextStyle(color: foregroundColor)),
    );
  }

  Future<void> _selectDateTime(
    BuildContext context,
    bool isRegisterDate,
  ) async {
    // 날짜 선택
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isRegisterDate
              ? _addContentState?.selectedRegDate
              : (_addContentState?.selectedExpDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // 시간 선택
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          isRegisterDate
              ? _addContentState?.selectedRegDate ?? DateTime.now()
              : (_addContentState?.selectedExpDate ?? DateTime.now()),
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

        if (isRegisterDate) {
          ref.watch(addContentProvider.notifier).setRegDate(combinedDateTime);
        } else {
          ref.watch(addContentProvider.notifier).setExpDate(combinedDateTime);
        }
      }
    }
  }
}
