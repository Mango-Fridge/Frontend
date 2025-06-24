import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:mango/view/asterisk_label.dart';
import 'package:mango/view/dotted_divider.dart';

class AddContentView extends ConsumerStatefulWidget {
  final RefrigeratorItem? item;
  const AddContentView({super.key, required this.item});
  @override
  ConsumerState<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends ConsumerState<AddContentView> {
  List<String> contentCategory = <String>[
    '육류',
    '음료류',
    '채소류',
    '과자류',
    '아이스크림류',
    '직접 입력',
  ];

  String? selectedCategory;
  String? customCategory;

  Group? get _group => ref.watch(groupProvider);
  AddContentState? get _addContentState => ref.watch(addContentProvider);

  static const int _memoMaxLine = 5;
  static const int _memoMaxLength = 100;

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  final TextEditingController countController = TextEditingController(
    text: '1',
  );
  TextEditingController brandNameController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController kcalController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController fatController = TextEditingController();

  final GlobalKey _countKey = GlobalKey();
  final GlobalKey _brandNameKey = GlobalKey();
  final GlobalKey _memoKey = GlobalKey();
  final GlobalKey _subCategoryKey = GlobalKey();
  final GlobalKey _capacityKey = GlobalKey();
  final GlobalKey _kcalKey = GlobalKey();
  final GlobalKey _carbsKey = GlobalKey();
  final GlobalKey _proteinKey = GlobalKey();
  final GlobalKey _fatKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  final OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black),
    borderRadius: BorderRadius.circular(16.0),
  );

  @override
  void initState() {
    super.initState();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(addContentProvider.notifier).resetState();

      final category = widget.item?.category ?? '';

      if (widget.item != null) {
        if (contentCategory.contains(category)) {
          ref.read(addContentProvider.notifier).setCategory(category);
          ref.read(addContentProvider.notifier).setCustomCategory('');
        } else {
          ref.read(addContentProvider.notifier).setCategory('직접 입력');
          ref.read(addContentProvider.notifier).setCustomCategory(category);
        }
      } else {
        ref.read(addContentProvider.notifier).setCategory(contentCategory[0]);
        ref.read(addContentProvider.notifier).setCustomCategory('');
      }

      // search에서 받아온 item을 text에 초기화 시켜주기 위함
      nameController = TextEditingController(text: widget.item?.itemName ?? "");
      ref
          .watch(addContentProvider.notifier)
          .updateNameErrorMessage(nameController.text);
      brandNameController = TextEditingController(
        text: widget.item?.brandName ?? '',
      );
      categoryController = TextEditingController(
        text: ref.watch(addContentProvider)?.customContentCategory,
      );
      subCategoryController = TextEditingController(
        text: widget.item?.subCategory ?? '',
      );
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
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '물품 추가 상세 입력',
            style: TextStyle(fontSize: Design.normalFontSize2),
          ),
          scrolledUnderElevation: 0,
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
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(child: bottomSubmitButtons()),
      ),
    );
  }

  Widget contentDetailInfoView() {
    final bool isCustomInput =
        ref.watch(addContentProvider)?.selectedContentCategory == '직접 입력';
    Design design = Design(context);
    return Column(
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
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: design.textFieldborderColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: design.textFieldborderColor),
            ),
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
        const SizedBox(height: 10),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: design.addContentTextWidth,
              child: const Row(
                children: <Widget>[
                  AsteriskLabel(text: '카테고리', color: Colors.red),
                ],
              ),
            ),
            isCustomInput
                ? Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: categoryController,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: textFieldBorder,
                          focusedBorder: textFieldBorder,
                        ),
                        onChanged: (String value) {
                          ref
                              .read(addContentProvider.notifier)
                              .setCustomCategory(value);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        ref
                            .read(addContentProvider.notifier)
                            .setCategory(contentCategory[0]);
                        ref
                            .read(addContentProvider.notifier)
                            .setCustomCategory('');
                      },
                    ),
                  ],
                )
                : DropdownButtonFormField2<String>(
                  value:
                      ref.watch(addContentProvider)?.selectedContentCategory ??
                      '직접 입력',
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: textFieldBorder,
                    enabledBorder: textFieldBorder,
                    focusedBorder: textFieldBorder,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: design.subColor,
                    ),
                  ),
                  buttonStyleData: const ButtonStyleData(
                    height: 30,
                    padding: EdgeInsets.only(right: 10),
                  ),
                  items:
                      contentCategory.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue == '직접 입력') {
                      ref
                          .read(addContentProvider.notifier)
                          .setCategory('직접 입력');
                      ref
                          .read(addContentProvider.notifier)
                          .setCustomCategory('');
                    } else {
                      ref
                          .read(addContentProvider.notifier)
                          .setCategory(newValue ?? '');
                      ref
                          .read(addContentProvider.notifier)
                          .setCustomCategory('');
                    }
                  },
                ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: <Widget>[
                SizedBox(
                  width: design.addContentTextWidth,
                  child: const Row(
                    children: <Widget>[
                      AsteriskLabel(text: '수량(인분)', color: Colors.red),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    key: _countKey,
                    textAlign: TextAlign.left,
                    onTap: () => _focusTextField(_countKey),
                    controller: countController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      enabledBorder: textFieldBorder,
                      focusedBorder: textFieldBorder,
                      errorBorder: textFieldBorder,
                      focusedErrorBorder: textFieldBorder,

                      isDense: true,
                    ),
                    onChanged: (String value) {
                      ref.watch(addContentProvider.notifier).updateCount(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                  child:
                      _addContentState?.contentCountErrorMessage?.isEmpty ??
                              true
                          ? null
                          : Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              _addContentState?.contentCountErrorMessage ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: <Widget>[
                SizedBox(
                  width: design.addContentTextWidth,
                  child: const Row(
                    children: <Widget>[
                      AsteriskLabel(text: '보관 장소', color: Colors.red),
                    ],
                  ),
                ),
                _doubleSegmentedControl(
                  segments: const <int, Widget>{1: Text('냉장'), 2: Text('냉동')},
                  onValueChanged: (int value) {
                    String storage = '';

                    switch (value) {
                      case 1:
                        storage = '냉장';
                        break;
                      case 2:
                        storage = '냉동';
                        break;
                    }
                    ref.watch(addContentProvider.notifier).setStorage(storage);
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: <Widget>[
            SizedBox(
              width: design.addContentTextWidth,
              child: const Row(
                children: <Widget>[
                  AsteriskLabel(text: '등록 날짜', color: Colors.red),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectDateTime(context, true);
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: design.textFieldborderColor),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat('yyyy년 M월 d일 a h시 m분', 'ko').format(
                      _addContentState?.selectedRegDate ?? DateTime.now(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: <Widget>[
            SizedBox(
              width: design.addContentTextWidth,
              child: const Row(
                children: <Widget>[
                  AsteriskLabel(text: '소비 기한', color: Colors.red),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectDateTime(context, false);
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: design.textFieldborderColor),
                ),
                child: Align(
                  alignment: Alignment.center,
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
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Container(
          padding: EdgeInsets.symmetric(vertical: design.marginAndPadding),
          child: dottedDivider(
            color: Colors.black.withAlpha(100),
            dashWidth: 1,
            text: '선택 사항',
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('선택사항 일부는 ', style: TextStyle(color: Colors.black87)),
            Text(
              '요리 재료 조회',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Design.normalFontSize1,
              ),
            ),
            Text(' / '),
            Text(
              '물품 검색',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Design.normalFontSize1,
              ),
            ),
            Text('에 사용됩니다.', style: TextStyle(color: Colors.black87)),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: <Widget>[
            SizedBox(
              width: design.screenWidth * 0.22,
              child: const Text(
                '브랜드 명',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Design.normalFontSize1,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  key: _brandNameKey,
                  onTap: () => _focusTextField(_brandNameKey),
                  controller: brandNameController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    enabledBorder: textFieldBorder,
                    focusedBorder: textFieldBorder,
                    hintText: "ex) 오리온",
                    hintStyle: const TextStyle(color: Colors.grey),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  '메모',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Design.normalFontSize1,
                  ),
                ),
                Text(
                  '* 물품 공개 등록에 포함되지 않습니다.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            TextField(
              key: _memoKey,
              onTap: () => _focusTextField(_memoKey),
              controller: memoController,
              maxLines: _memoMaxLine,
              maxLength: _memoMaxLength,
              decoration: InputDecoration(
                hintText: "최대 100자 까지 작성 가능합니다.",
                filled: true,
                fillColor: design.subColor,
                enabledBorder: textFieldBorder,
                focusedBorder: textFieldBorder,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: design.addContentTextWidth,
              child: const Row(
                spacing: 10,
                children: <Widget>[
                  Text(
                    '중분류',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Design.normalFontSize1,
                    ),
                  ),
                  Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: "중분류는 요리 재료 검색 시 사용되는 정보입니다.",
                    child: Icon(Icons.help_outline),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  key: _subCategoryKey,
                  onTap: () => _focusTextField(_subCategoryKey),
                  controller: subCategoryController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    enabledBorder: textFieldBorder,
                    focusedBorder: textFieldBorder,
                    hintText: "ex) 돼지고기, 소고기",
                    hintStyle: const TextStyle(color: Colors.grey),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        nutritionView(),
      ],
    );
  }

  Widget nutritionView() {
    Design design = Design(context);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        children: <Widget>[
          const Row(
            spacing: 10,
            children: <Widget>[
              Text(
                '영양 성분',
                style: TextStyle(
                  fontSize: Design.normalFontSize1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: "각 영양 성분을 입력해야 \n'물품 공개 등록' 버튼을 \n활성화할 수 있습니다.",
                child: Icon(Icons.help_outline),
              ),
              Spacer(),
              Text(
                '* 공개 등록 필수 기입사항',
                style: TextStyle(
                  fontSize: Design.normalFontSize0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            spacing: 20,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          spacing: 10,
                          children: <Widget>[
                            SizedBox(
                              width: design.addContentNutritionTextWidth,
                              child: const Row(
                                spacing: 2,
                                children: <Widget>[
                                  AsteriskLabel(
                                    text: '1회 제공 용량',
                                    color: Colors.indigo,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: TextField(
                            key: _capacityKey,
                            keyboardType: TextInputType.number,
                            controller: capacityController,
                            textAlign: TextAlign.left,
                            enabled: widget.item == null,
                            style: const TextStyle(color: Colors.black),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              hintText: 'ex) 150',
                              enabledBorder: textFieldBorder,
                              disabledBorder: textFieldBorder,
                              focusedBorder: textFieldBorder,
                              isDense: true,
                            ),
                            onChanged: (String? newValue) {
                              ref
                                  .read(addContentProvider.notifier)
                                  .updateCapacity(capacityController.text);
                            },
                            onTap: () => _focusTextField(_capacityKey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              spacing: 10,
                              children: <Widget>[
                                SizedBox(
                                  width: design.addContentNutritionTextWidth,
                                  child: const Row(
                                    spacing: 2,
                                    children: <Widget>[
                                      AsteriskLabel(
                                        text: '단위',
                                        color: Colors.indigo,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _doubleSegmentedControl(
                          segments: const <int, Widget>{
                            1: Text(' g '),
                            2: Text('ml'),
                          },
                          onValueChanged: (int value) {
                            String unit = '';

                            switch (value) {
                              case 1:
                                unit = 'g';
                                break;
                              case 2:
                                unit = 'ml';
                                break;
                            }
                            ref
                                .watch(addContentProvider.notifier)
                                .setUnit(unit);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: optionTextField(
                      key: _kcalKey,
                      label: '열량',
                      controller: kcalController,
                      enabled: widget.item == null,
                      hintText: 'ex) 150',
                      textInputType: TextInputType.number,
                      onChanged: () {
                        ref
                            .read(addContentProvider.notifier)
                            .updateKcal(kcalController.text);
                      },
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: optionTextField(
                      key: _carbsKey,
                      label: '탄수화물',
                      controller: carbsController,
                      enabled: widget.item == null,
                      hintText: 'ex) 150',
                      textInputType: TextInputType.number,
                      onChanged: () {
                        ref
                            .read(addContentProvider.notifier)
                            .updateCarbs(carbsController.text);
                      },
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: optionTextField(
                      key: _proteinKey,
                      label: '단백질',
                      controller: proteinController,
                      enabled: widget.item == null,
                      hintText: 'ex) 150',
                      textInputType: TextInputType.number,
                      onChanged: () {
                        ref
                            .read(addContentProvider.notifier)
                            .updateProtein(proteinController.text);
                      },
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: optionTextField(
                      key: _fatKey,
                      label: '지방',
                      controller: fatController,
                      enabled: widget.item == null,
                      hintText: 'ex) 150',
                      textInputType: TextInputType.number,
                      onChanged: () {
                        ref
                            .read(addContentProvider.notifier)
                            .updateFat(fatController.text);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: design.screenHeight * 0.3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _doubleSegmentedControl({
    required Map<int, Widget> segments,
    required void Function(int) onValueChanged,
  }) {
    final Design design = Design(context);
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: CustomSlidingSegmentedControl<int>(
        fixedWidth: design.addContentNutritionTextWidth - 19,
        initialValue: 1,
        height: 42,
        children: segments,
        decoration: BoxDecoration(
          border: Border.all(color: design.textFieldborderColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        thumbDecoration: BoxDecoration(
          color: design.mainColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withAlpha(150),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(0.0, 1.0),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        onValueChanged: onValueChanged,
      ),
    );
  }

  // Bottom Submit Buttons
  Widget bottomSubmitButtons() {
    final Design design = Design(context);
    return Padding(
      padding: EdgeInsets.all(design.marginAndPadding),
      child: SizedBox(
        height: design.homeBottomHeight,
        child: Row(
          spacing: 10,
          children: <Widget>[
            if (widget.item == null)
              Expanded(
                child: buildElevatedButton(
                  label: "물품 공개 + 등록\n(검색 허용)",
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
                                  brandNameController.text,
                                  int.parse(countController.text),
                                  _addContentState?.selectedRegDate ??
                                      DateTime.now(),
                                  _addContentState?.selectedExpDate ??
                                      DateTime.now(),
                                  _addContentState?.selectedContentStorage ??
                                      '냉장',
                                  memoController.text,
                                  _addContentState?.selectedUnit ?? 'g',
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
                label: '냉장고에 등록',
                onPressed:
                    _addContentState?.isDetailInfoEmpty ?? false
                        ? () async {
                          await ref
                              .watch(addContentProvider.notifier)
                              .saveItem(
                                _group?.groupId ?? 0,
                                nameController.text,
                                false,
                                _addContentState?.selectedContentCategory ==
                                        '직접 입력'
                                    ? _addContentState?.customContentCategory ??
                                        contentCategory[0]
                                    : _addContentState
                                            ?.selectedContentCategory ??
                                        contentCategory[0],
                                subCategoryController.text,
                                brandNameController.text,
                                int.parse(countController.text),
                                _addContentState?.selectedRegDate ??
                                    DateTime.now(),
                                _addContentState?.selectedExpDate ??
                                    DateTime.now(),
                                _addContentState?.selectedContentStorage ??
                                    '냉장',
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
        ),
      ),
    );
  }

  Widget optionTextField({
    required GlobalKey key,
    required String label,
    required TextEditingController controller,
    required bool enabled,
    required String hintText,
    required VoidCallback onChanged,
    required TextInputType textInputType,
  }) {
    final Design design = Design(context);
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: design.addContentNutritionTextWidth,
          child: Row(
            spacing: 2,
            children: <Widget>[
              AsteriskLabel(text: label, color: Colors.indigo),
            ],
          ),
        ),
        SizedBox(
          child: TextField(
            key: key,
            keyboardType: textInputType,
            controller: controller,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.black),
            enabled: enabled,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: textFieldBorder,
              disabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
              isDense: true,
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
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey.shade300;
            }
            return backgroundColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey.shade600;
            }
            return foregroundColor;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(color: borderColor, width: 2.0),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: foregroundColor),
          textAlign: TextAlign.center,
        ),
      ),
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
          bool isAfter = ref
              .watch(addContentProvider.notifier)
              .setExpDate(combinedDateTime);
          if (!isAfter) {
            toastMessage(
              context,
              '소비 기한은 등록 날짜 보다 이전일 수 없습니다.',
              type: ToastmessageType.errorType,
            );
          }
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
