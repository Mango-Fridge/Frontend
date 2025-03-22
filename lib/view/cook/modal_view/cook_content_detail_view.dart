import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/design.dart';

class CookContentDetailView extends ConsumerWidget {
  const CookContentDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Design design = Design(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: <Widget>[
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("요리 이름"), Text("제조사")],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text("닫기"),
            ),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text("추가"),
            ),
          ],
        ),
      ],
    );

    // TODO: implement build
    throw UnimplementedError();
  }
}
