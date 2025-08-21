import 'dart:async' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/domain/timer.dart';

class TimerWidget extends ConsumerStatefulWidget {
  const TimerWidget({super.key, required this.timer});
  final Timer timer;

  @override
  ConsumerState<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends ConsumerState<TimerWidget> {
  late Duration _durationLeft;
  d.Timer? _updateTimer;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    _updateDuration();

    // Set timer update frequency based on remaining duration
    _setUpdateTimer();
  }

  void _updateDuration() {
    final now = DateTime.now();
    if (widget.timer.enddate.isAfter(now)) {
      _durationLeft = widget.timer.enddate.difference(now);
    } else {
      _durationLeft = Duration.zero;
      completed = true;
      _updateTimer?.cancel();
    }
  }

  void _setUpdateTimer() {
    _updateTimer?.cancel();

    if (_durationLeft.inMinutes <= 60) {
      // Update every minute if within 60 minutes
      _updateTimer = d.Timer.periodic(const Duration(minutes: 1), (_) {
        setState(() {
          _updateDuration();
        });
      });
    } else if (_durationLeft.inHours <= 24) {
      // Update every hour if within 24 hours
      _updateTimer = d.Timer.periodic(const Duration(hours: 1), (_) {
        setState(() {
          _updateDuration();
        });
      });
    }
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  String _formatDuration() {
    if (_durationLeft == Duration.zero) {
      return "Completed";
    } else if (_durationLeft.inMinutes <= 60) {
      return "${_durationLeft.inMinutes} minutes";
    } else if (_durationLeft.inHours <= 24) {
      return "${_durationLeft.inHours} hours";
    } else {
      return "${_durationLeft.inDays} days";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.timer.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            Text(
              _formatDuration(),
              style: TextStyle(
                fontSize: 16,
                color:
                    _durationLeft == Duration.zero ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
