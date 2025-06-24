import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeAgoNotifier extends AutoDisposeFamilyNotifier<String, DateTime> {
  late DateTime _lastUpdated;
  Timer? _timer;

  @override
  String build(DateTime arg) {
    _lastUpdated = arg;
    _startTimer();
    return _formatTimeAgo();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      state = _formatTimeAgo();
    });
  }

  String _formatTimeAgo() {
    final Duration diff = DateTime.now().difference(_lastUpdated);

    if (diff.inMinutes < 1) {
      return '방금 전';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else {
      return '${diff.inDays}일 전';
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}

final AutoDisposeNotifierProviderFamily<TimeAgoNotifier, String, DateTime>
timeAgoNotifierProvider = NotifierProvider.autoDispose
    .family<TimeAgoNotifier, String, DateTime>(TimeAgoNotifier.new);
