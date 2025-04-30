import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
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
    final bool isCustomInput =
        ref.watch(addContentProvider)?.selectedContentCategory == '직접 입력';
    Design design = Design(context);
    return Column(
      spacing: 20,
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
              borderSide: BorderSide(
                color: design.textFieldborderColor,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: design.textFieldborderColor,
                width: 2,
              ),
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
              child:
                  isCustomInput
                      ? Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: categoryController,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: design.textFieldborderColor,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: design.textFieldborderColor,
                                  ),
                                ),
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
                            ref
                                .watch(addContentProvider)
                                ?.selectedContentCategory ??
                            '직접 입력',
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: design.textFieldborderColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: design.textFieldborderColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: design.textFieldborderColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: design.subColor,
                          ),
                        ),
                        buttonStyleData: const ButtonStyleData(
                          height: 20,
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
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(
              width: 150,
              child: TextField(
                key: _countKey,
                textAlign: TextAlign.right,
                onTap: () => _focusTextField(_countKey),
                controller: countController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: design.textFieldborderColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: design.textFieldborderColor),
                  ),
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
              child: GestureDetector(
                onTap: () {
                  _selectDateTime(context, true);
                },
                child: Container(
                  padding: EdgeInsets.all(design.marginAndPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: design.textFieldborderColor,
                      width: 2,
                    ),
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
              child: GestureDetector(
                onTap: () {
                  _selectDateTime(context, false);
                },
                child: Container(
                  padding: EdgeInsets.all(design.marginAndPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: design.textFieldborderColor,
                      width: 2,
                    ),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: CustomSlidingSegmentedControl<int>(
                padding: design.marginAndPadding * 2,
                initialValue: 1,
                children: const <int, Widget>{1: Text('냉장'), 2: Text('냉동')},
                decoration: BoxDecoration(
                  border: Border.all(
                    color: design.textFieldborderColor,
                    width: 2,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                thumbDecoration: BoxDecoration(
                  color: design.subColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: design.textFieldborderColor.withAlpha(150),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
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
            ),
          ],
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: design.marginAndPadding),
          child: dottedDivider(
            color: Colors.green,
            dashWidth: 1,
            text: '선택 사항',
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('선택사항 일부는 '),
            Text(
              '요리',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(' / '),
            Text(
              '물품 검색',
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('에 사용됩니다.'),
          ],
        ),
        Row(
          spacing: 10,
          children: <Widget>[
            SizedBox(
              width: design.screenWidth * 0.22,
              child: const Text(
                '브랜드 명',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    key: _brandNameKey,
                    onTap: () => _focusTextField(_brandNameKey),
                    controller: brandNameController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: design.textFieldborderColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: design.textFieldborderColor,
                        ),
                      ),
                      hintText: "ex) 오리온",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('메모', style: TextStyle(fontWeight: FontWeight.bold)),
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
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: design.textFieldborderColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: design.textFieldborderColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: design.screenWidth * 0.22,
              child: const Row(
                spacing: 10,
                children: [
                  Text('중분류', style: TextStyle(fontWeight: FontWeight.bold)),
                  Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: "중분류는 요리 재료 검색 시 사용되는 정보입니다.",
                    child: Icon(Icons.help_outline),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    key: _subCategoryKey,
                    onTap: () => _focusTextField(_subCategoryKey),
                    controller: subCategoryController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: design.textFieldborderColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: design.textFieldborderColor,
                        ),
                      ),
                      hintText: "ex) 돼지고기, 소고기",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        nutritionView(),
      ],
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
                fontSize: Design.normalFontSize1,
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
                enabled: widget.item == null,
                hintText: 'ex) 150',
                textInputType: TextInputType.number,
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
                enabled: widget.item == null,
                hintText: 'ex) 50',
                textInputType: TextInputType.number,
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
                enabled: widget.item == null,
                hintText: 'ex) 150',
                textInputType: TextInputType.number,
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
                enabled: widget.item == null,
                hintText: 'ex) 150',
                textInputType: TextInputType.number,
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
                              brandNameController.text,
                              int.parse(countController.text),
                              _addContentState?.selectedRegDate ??
                                  DateTime.now(),
                              _addContentState?.selectedExpDate ??
                                  DateTime.now(),
                              _addContentState?.selectedContentStorage ?? '냉장',
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
                            _addContentState?.selectedContentCategory == '직접 입력'
                                ? _addContentState?.customContentCategory ??
                                    contentCategory[0]
                                : _addContentState?.selectedContentCategory ??
                                    contentCategory[0],
                            subCategoryController.text,
                            brandNameController.text,
                            int.parse(countController.text),
                            _addContentState?.selectedRegDate ?? DateTime.now(),
                            _addContentState?.selectedExpDate ?? DateTime.now(),
                            _addContentState?.selectedContentStorage ?? '냉장',
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
    required bool enabled,
    required String hintText,
    required VoidCallback onChanged,
    required TextInputType textInputType,
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
            keyboardType: textInputType,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            enabled: enabled,
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
