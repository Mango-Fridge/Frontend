import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:intl/intl.dart';
import 'package:mango/providers/add_content_provider.dart';
import 'package:mango/providers/content_provider.dart';
import 'package:mango/state/add_content_state.dart';

class AddContentView extends ConsumerStatefulWidget {
  const AddContentView({super.key});
  @override
  ConsumerState<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends ConsumerState<AddContentView> {
  List<String> contentCategory = <String>['육류', '음료류', '채소류', '과자류', '아이스크림류'];
  List<String> contentStorage = <String>['냉장', '냉동'];

  AddContentState? get addContentState => ref.watch(addContentProvider);

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
  void initState() {
    super.initState();
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      style: const TextStyle(fontSize: 22.0),
                      decoration: InputDecoration(
                        hintText: '물품 명을 입력해 주세요',
                        errorText:
                            addContentState?.contentNameErrorMessage?.isEmpty ??
                                    true
                                ? null
                                : addContentState?.contentNameErrorMessage,
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
                              Text('카테고리 '),
                              Text('*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value:
                                addContentState?.selectedContentCategory ??
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
                              Text('수량 (인분) '),
                              Text('*', style: TextStyle(color: Colors.red)),
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
                                  addContentState
                                              ?.contentCountErrorMessage
                                              ?.isEmpty ??
                                          true
                                      ? null
                                      : addContentState
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
                              Text('등록 날짜 '),
                              Text('*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat('a yyyy년 M월 d일 h시 mm분', 'ko').format(
                              addContentState?.selectedRegDate ??
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
                              Text('소비 기한 '),
                              Text('*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),

                        Expanded(
                          // expirationDate가 null일 때 예외 처리, 이건 submit 할 때.
                          child: Text(
                            addContentState?.selectedExpDate == null
                                ? '날짜를 선택하세요'
                                : DateFormat(
                                  'a yyyy년 M월 d일 h시 mm분',
                                  'ko',
                                ).format(
                                  addContentState!.selectedExpDate ??
                                      DateTime.now(),
                                ),
                            style: TextStyle(
                              color:
                                  addContentState?.selectedExpDate == null
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
                              Text('보관 장소 '),
                              Text('*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value:
                                addContentState?.selectedContentStorage ??
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
                          child: const Text('메모'),
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
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Row(
                        spacing: 10,
                        children: <Widget>[
                          Text('영양 성분', style: TextStyle(fontSize: 14)),
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
                                  child: const Text('단위'),
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
            Row(
              spacing: 10,
              children: <Widget>[
                Expanded(
                  child: buildElevatedButton(
                    label: '물품 공개 등록',
                    onPressed:
                        addContentState?.isNutritionEmpty ?? false
                            ? () {
                              print('test');
                            }
                            : null,
                    backgroundColor: Colors.amber[200]!,
                    foregroundColor: Colors.black,
                  ),
                ),
                Expanded(
                  child: buildElevatedButton(
                    label: '물품 등록',
                    onPressed:
                        addContentState?.isDetailInfoEmpty ?? false
                            ? () {
                              ref
                                  .watch(contentProvider.notifier)
                                  .saveContent(
                                    nameController.text,
                                    addContentState?.selectedContentCategory ??
                                        contentCategory[0],
                                    int.parse(countController.text),
                                    addContentState?.selectedRegDate ??
                                        DateTime.now(),
                                    addContentState?.selectedRegDate ??
                                        DateTime.now(),
                                    addContentState?.selectedContentStorage ??
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
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

  Future<void> _selectDateTime(
    BuildContext context,
    bool isRegisterDate,
  ) async {
    // 날짜 선택
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isRegisterDate
              ? addContentState?.selectedRegDate
              : (addContentState?.selectedExpDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // 시간 선택
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          isRegisterDate
              ? addContentState?.selectedRegDate ?? DateTime.now()
              : (addContentState?.selectedExpDate ?? DateTime.now()),
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
