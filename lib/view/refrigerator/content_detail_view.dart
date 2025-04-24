import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';
import 'package:mango/providers/refrigerator_provider.dart';

class ContentDetailView extends ConsumerStatefulWidget {
  const ContentDetailView({super.key, required this.content});

  final Content content;

  @override
  ConsumerState<ContentDetailView> createState() => _ContentDetailViewState();
}

class _ContentDetailViewState extends ConsumerState<ContentDetailView> {
  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(design.marginAndPadding),
        child: Column(
          children: <Widget>[
            const Text('〈등록날짜〉', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              DateFormat(
                'yyyy년 M월 d일 a h시 m분',
                'ko',
              ).format(widget.content.regDate ?? DateTime.now()),
            ),
            const SizedBox(height: 12),
            Text(
              widget.content.contentName,
              style: const TextStyle(
                fontSize: Design.normalFontSize3,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.content.brandName != ''
                ? Text(
                  '${widget.content.brandName}',
                  style: const TextStyle(fontSize: Design.normalFontSize1),
                )
                : const Text(
                  '등록 된 업체명이 없습니다.',
                  style: TextStyle(
                    fontSize: Design.normalFontSize1,
                    color: Colors.grey,
                  ),
                ),
            const SizedBox(height: 20),
            Row(
              spacing: 10,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          '남은 기한',
                          style: TextStyle(
                            fontSize: Design.normalFontSize1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ref
                              .watch(refrigeratorNotifier.notifier)
                              .getRemainDate(
                                widget.content.expDate ?? DateTime.now(),
                              ),
                          style: const TextStyle(
                            fontSize: Design.normalFontSize2,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${DateFormat('yyyy-M-dd a h시 m분', 'ko').format(widget.content.expDate ?? DateTime.now())}까지',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  spacing: 5,
                  children: <Widget>[
                    categoryBox('카테고리', '${widget.content.category}'),
                    categoryBox('중분류명', '${widget.content.subCategory}'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '총 중량 ${widget.content.nutriCapacity}${widget.content.nutriUnit}g  /',
                  ),
                  nutrientText(
                    '탄수화물',
                    '${widget.content.nutriCarbohydrate}',
                    Colors.green,
                  ),
                  nutrientText(
                    '단백질',
                    '${widget.content.nutriProtein}',
                    Colors.orange,
                  ),
                  nutrientText(
                    '지방',
                    '${widget.content.nutriFat}',
                    Colors.brown,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 150,
              padding: EdgeInsets.all(design.marginAndPadding),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Center(
                child:
                    widget.content.memo != ''
                        ? Text(
                          '${widget.content.memo}',
                          style: const TextStyle(color: Colors.black),
                        )
                        : const Text(
                          '메모가 없습니다.',
                          style: TextStyle(color: Colors.grey),
                        ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                minimumSize: const Size(120, 50),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryBox(String label, String value) {
    final Design design = Design(context);
    return Container(
      padding: EdgeInsets.only(
        left: design.marginAndPadding * 4,
        right: design.marginAndPadding * 4,
        top: 6,
        bottom: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget nutrientText(String name, String value, Color color) {
    return Column(
      children: <Widget>[
        Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text(
          value,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
