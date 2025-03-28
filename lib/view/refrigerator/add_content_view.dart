import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:intl/intl.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/add_content_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/refrigerator_provider.dart';
import 'package:mango/state/add_content_state.dart';
import 'package:mango/toastMessage.dart';

class AddContentView extends ConsumerStatefulWidget {
  final RefrigeratorItem? item;
  const AddContentView({super.key, required this.item});
  @override
  ConsumerState<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends ConsumerState<AddContentView> {
  List<String> contentCategory = <String>['육류', '음료류', '채소류', '과자류', '아이스크림류'];
  List<String> contentStorage = <String>['냉장', '냉동'];

  Group? get _group => ref.watch(groupProvider);
  AddContentState? get _addContentState => ref.watch(addContentProvider);

  static const int _memoMaxLine = 3;
  static const int _memoMaxLength = 120;

  TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController(
    text: '1',
  );
  final TextEditingController memoController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController kcalController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController fatController = TextEditingController();

  final GlobalKey _countKey = GlobalKey();
  final GlobalKey _memoKey = GlobalKey();
  final GlobalKey _subCategoryKey = GlobalKey();
  final GlobalKey _capacityKey = GlobalKey();
  final GlobalKey _kcalKey = GlobalKey();
  final GlobalKey _carbsKey = GlobalKey();
  final GlobalKey _proteinKey = GlobalKey();
  final GlobalKey _fatKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(addContentProvider.notifier).resetState();

      // search에서 받아온 item을 text에 초기화 시켜주기 위함
      nameController = TextEditingController(text: widget.item?.itemName ?? "");
      ref
          .watch(addContentProvider.notifier)
          .updateNameErrorMessage(nameController.text);
      capacityController = TextEditingController(
        text: widget.item?.nutriCapacity.toString() ?? '',
      );
      kcalController = TextEditingController(
        text: widget.item?.nutriKcal.toString() ?? '',
      );
      carbsController = TextEditingController(
        text: widget.item?.nutriCarbohydrate.toString() ?? '',
      );
      proteinController = TextEditingController(
        text: widget.item?.nutriProtein.toString() ?? '',
      );
      fatController = TextEditingController(
        text: widget.item?.nutriFat.toString() ?? '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Design design = Design(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
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
                  controller: _scrollController,
                  // Content detail info view
                  child: contentDetailInfoView(),
                ),
              ),
              bottomSubmitButtons(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentDetailInfoView() {
    Design design = Design(context);
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: nameController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Design.itemNameFontSize,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'ex) 촉촉한 초코칩',
            hintStyle: const TextStyle(color: Colors.grey),
            errorText:
                _addContentState?.contentNameErrorMessage?.isEmpty ?? true
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
                  Text('카테고리 ', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    widget.item?.category ??
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
                onChanged:
                    widget.item != null
                        ? null
                        : (String? newValue) {
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
                key: _countKey,
                onTap: () => _focusTextField(_countKey),
                controller: countController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText:
                      _addContentState?.contentCountErrorMessage?.isEmpty ??
                              true
                          ? null
                          : _addContentState?.contentCountErrorMessage,
                ),
                onChanged: (String value) {
                  ref.watch(addContentProvider.notifier).updateCount(value);
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
                  Text('등록 날짜 ', style: TextStyle(fontWeight: FontWeight.bold)),
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
                DateFormat(
                  'yyyy년 M월 d일 a h시 m분',
                  'ko',
                ).format(_addContentState?.selectedRegDate ?? DateTime.now()),
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
                  Text('소비 기한 ', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    : DateFormat('yyyy년 M월 d일 a h시 m분', 'ko').format(
                      _addContentState!.selectedExpDate ?? DateTime.now(),
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
                  Text('보관 장소 ', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    key: _memoKey,
                    onTap: () => _focusTextField(_memoKey),
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
        optionView(),
        nutritionView(),
      ],
    );
  }

  Widget optionView() {
    Design design = Design(context);

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        title: const Row(
          spacing: 10,
          children: <Widget>[
            Text(
              '선택 사항',
              style: TextStyle(
                fontSize: Design.normalFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: "중분류는 요리 재료 검색 시 사용되는 정보입니다.",
              child: Icon(Icons.help_outline),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            spacing: 10,
            children: <Widget>[
              optionTextField(
                key: _subCategoryKey,
                label: '중분류',
                controller: subCategoryController,
                hintText: 'ex) 밥',
                onChanged: () {
                  ref
                      .read(addContentProvider.notifier)
                      .updateKcal(subCategoryController.text);
                },
              ),
              const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget nutritionView() {
    Design design = Design(context);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: const Row(
          spacing: 10,
          children: <Widget>[
            Text(
              '영양 성분',
              style: TextStyle(
                fontSize: Design.normalFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: "각 영양 성분을 입력해야 \n'물품 공개 등록' 버튼을 \n활성화할 수 있습니다.",
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      key: _capacityKey,
                      keyboardType: TextInputType.number,
                      controller: capacityController,
                      enabled: widget.item == null,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ex) 150',
                      ),
                      onChanged: (String? newValue) {
                        ref
                            .read(addContentProvider.notifier)
                            .updateCapacity(capacityController.text);
                      },
                      onTap: () => _focusTextField(_capacityKey),
                    ),
                  ),
                  buildElevatedButton(
                    label: 'g',
                    onPressed:
                        (widget.item != null)
                            ? null
                            : () {
                              ref
                                  .watch(addContentProvider.notifier)
                                  .setUnit('g');
                            },
                    backgroundColor: Colors.amber[300]!,
                    foregroundColor: Colors.black,
                    borderColor:
                        widget.item?.nutriUnit == 'g' ||
                                _addContentState?.selectedUnit == 'g'
                            ? Colors.red
                            : Colors.transparent,
                  ),
                  buildElevatedButton(
                    label: 'ml',
                    onPressed:
                        (widget.item != null)
                            ? null
                            : () {
                              ref
                                  .watch(addContentProvider.notifier)
                                  .setUnit('ml');
                            },
                    backgroundColor: Colors.amber[300]!,
                    foregroundColor: Colors.black,
                    borderColor:
                        widget.item?.nutriUnit == 'ml' ||
                                _addContentState?.selectedUnit == 'ml'
                            ? Colors.red
                            : Colors.transparent,
                  ),
                ],
              ),
              optionTextField(
                key: _kcalKey,
                label: '열량',
                controller: kcalController,
                hintText: 'ex) 150',
                onChanged: () {
                  ref
                      .read(addContentProvider.notifier)
                      .updateKcal(kcalController.text);
                },
              ),
              optionTextField(
                key: _carbsKey,
                label: '탄수화물',
                controller: carbsController,
                hintText: 'ex) 50',
                onChanged: () {
                  ref
                      .read(addContentProvider.notifier)
                      .updateCarbs(carbsController.text);
                },
              ),
              optionTextField(
                key: _proteinKey,
                label: '단백질',
                controller: proteinController,
                hintText: 'ex) 150',
                onChanged: () {
                  ref
                      .read(addContentProvider.notifier)
                      .updateProtein(proteinController.text);
                },
              ),
              optionTextField(
                key: _fatKey,
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
    );
  }

  // Bottom Submit Buttons
  Widget bottomSubmitButtons() {
    return Row(
      spacing: 10,
      children: <Widget>[
        if (widget.item == null)
          Expanded(
            child: buildElevatedButton(
              label: '물품 공개 등록',
              onPressed:
                  widget.item == null &&
                          _addContentState!.isNutritionEmpty &&
                          _addContentState!.isDetailInfoEmpty
                      ? () async {
                        await ref
                            .watch(addContentProvider.notifier)
                            .saveItem(
                              _group?.groupId ?? 0,
                              nameController.text,
                              true,
                              _addContentState?.selectedContentCategory ??
                                  contentCategory[0],
                              subCategoryController.text,
                              '',
                              int.parse(countController.text),
                              _addContentState?.selectedRegDate ??
                                  DateTime.now(),
                              _addContentState?.selectedExpDate ??
                                  DateTime.now(),
                              _addContentState?.selectedContentStorage ??
                                  contentStorage[0],
                              memoController.text,
                              _addContentState?.selectedUnit ?? '',
                              capacityController.text.isNotEmpty
                                  ? int.parse(capacityController.text)
                                  : 0,
                              kcalController.text.isNotEmpty
                                  ? int.parse(kcalController.text)
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

                        toastMessage(
                          context,
                          "${nameController.text}(이)가 정상적으로\n공개등록이 되었습니다!",
                        );

                        await ref
                            .read(refrigeratorNotifier.notifier)
                            .loadContentList(_group?.groupId ?? 0);
                        context.pop();
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
                    ? () async {
                      await ref
                          .watch(addContentProvider.notifier)
                          .saveItem(
                            _group?.groupId ?? 0,
                            nameController.text,
                            false,
                            _addContentState?.selectedContentCategory ??
                                contentCategory[0],
                            subCategoryController.text,
                            '',
                            int.parse(countController.text),
                            _addContentState?.selectedRegDate ?? DateTime.now(),
                            _addContentState?.selectedExpDate ?? DateTime.now(),
                            _addContentState?.selectedContentStorage ??
                                contentStorage[0],
                            memoController.text,
                            _addContentState?.selectedUnit ?? '',
                            capacityController.text.isNotEmpty
                                ? int.parse(capacityController.text)
                                : 0,
                            kcalController.text.isNotEmpty
                                ? int.parse(kcalController.text)
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
                      toastMessage(
                        context,
                        "${nameController.text}(이)가 정상적으로\n추가되었습니다!",
                      );
                      await ref
                          .read(refrigeratorNotifier.notifier)
                          .loadContentList(_group?.groupId ?? 0);
                      context.pop();
                    }
                    : null,
            backgroundColor: Colors.amber[300]!,
            foregroundColor: Colors.black,
            borderColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget optionTextField({
    required GlobalKey key,
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
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: TextField(
            key: key,
            keyboardType: TextInputType.number,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            enabled: widget.item == null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged();
              }
            },
            onTap: () => _focusTextField(key),
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

  void _focusTextField(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context, // BuildContext 전달
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5, // 중앙 설정
        );
      }
    });
  }
}
