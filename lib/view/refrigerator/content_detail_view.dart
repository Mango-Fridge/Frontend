import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';

class ContentDetailView extends ConsumerStatefulWidget {
  const ContentDetailView({super.key, required this.content});

  final Content content;

  @override
  ConsumerState<ContentDetailView> createState() => _ContentDetailViewState();
}

class _ContentDetailViewState extends ConsumerState<ContentDetailView> {
  @override
  Widget build(BuildContext context) {
    Design design = Design(context);

    return SizedBox(
      width: design.termsOverlayWidth,
      height: design.termsOverlayHeight * 0.85,
      child: Column(
        spacing: 10,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.content.contentName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
            ],
          ),
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('카테고리: ${widget.content.category}'),
              Text('수량: ${widget.content.count}'),
              Text(
                '등록 날짜: ${DateFormat('a yyyy년 M월 d일 h시 mm분', 'ko').format(widget.content.regDate)}',
              ),
              Text(
                '소비 기한: ${DateFormat('a yyyy년 M월 d일 h시 mm분', 'ko').format(widget.content.expDate)}',
              ),
              Text('보관 장소: ${widget.content.storageArea}'),
              Text('메모: ${widget.content.memo}', maxLines: 3),
              const Divider(),
              const Text(
                '영양 성분',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('단위: ${widget.content.nutriCapacity}'),
              Text('열량: ${widget.content.nutriKcal}'),
              Text('탄수화물: ${widget.content.nutriCarbohydrate}'),
              Text('단백질: ${widget.content.nutriProtein}'),
              Text('지방: ${widget.content.nutriFat}'),
            ],
          ),
        ],
      ),
    );
  }
}
