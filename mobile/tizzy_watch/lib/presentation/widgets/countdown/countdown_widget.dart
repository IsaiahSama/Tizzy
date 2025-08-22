import 'dart:async' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizzy_watch/core/client.dart';
import 'package:tizzy_watch/core/constants.dart';
import 'package:tizzy_watch/domain/countdown.dart';
import 'package:tizzy_watch/core/providers/countdown_provider.dart';
import 'package:home_widget/home_widget.dart';

class CountdownWidget extends ConsumerStatefulWidget {
  const CountdownWidget({super.key, required this.countdown});
  final Countdown countdown;

  @override
  ConsumerState<CountdownWidget> createState() => _CountdownWidgetState();
}

const String widgetName = "CountdownWidget";

class _CountdownWidgetState extends ConsumerState<CountdownWidget> {
  late Duration _durationLeft;
  d.Timer? _updateCountdown;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    _updateDuration();

    // Set countdown update frequency based on remaining duration
    _setUpdateCountdown();
  }

  void _updateDuration() {
    final now = DateTime.now();
    if (widget.countdown.enddate.isAfter(now)) {
      _durationLeft = widget.countdown.enddate.difference(now);
    } else {
      _durationLeft = Duration.zero;
      completed = true;
      _updateCountdown?.cancel();
    }
  }

  void _setUpdateCountdown() {
    _updateCountdown?.cancel();

    if (_durationLeft.inMinutes <= 60) {
      // Update every minute if within 60 minutes
      _updateCountdown = d.Timer.periodic(const Duration(minutes: 1), (_) {
        setState(() {
          _updateDuration();
        });
      });
    } else if (_durationLeft.inHours <= 24) {
      // Update every hour if within 24 hours
      _updateCountdown = d.Timer.periodic(const Duration(hours: 1), (_) {
        setState(() {
          _updateDuration();
        });
      });
    }
  }

  @override
  void dispose() {
    _updateCountdown?.cancel();
    super.dispose();
  }

  String _formatDuration() {
    if (_durationLeft <= Duration.zero) {
      return "Completed";
    } else if (_durationLeft.inMinutes <= 1) {
      return "less than 1 minute remains";
    } else if (_durationLeft.inMinutes <= 60) {
      return "${_durationLeft.inMinutes} minutes remain";
    } else if (_durationLeft.inHours <= 24) {
      return "${_durationLeft.inHours} ${_durationLeft.inHours == 1 ? 'hour remains' : 'hours remain'}";
    } else {
      return "${_durationLeft.inDays} ${_durationLeft.inDays == 1 ? 'day remains' : 'days remain'}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showOptionsModal(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Column(
                children: [
                  Text(
                    widget.countdown.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          _durationLeft == Duration.zero
                              ? Colors.green.withAlpha(25)
                              : Colors.red.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _formatDuration(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            _durationLeft == Duration.zero
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(
                      context,
                    ).dividerColor.withAlpha(51), // 0.2 * 255 ≈ 51
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ref
                            .read(countdownsProvider.notifier)
                            .deleteCountdown(widget.countdown.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: Colors.red.shade400,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Theme.of(
                      context,
                    ).dividerColor.withAlpha(51), // 0.2 * 255 ≈ 51
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(widget.countdown.enddate.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share with partner'),
              onTap: () {
                Navigator.pop(context);
                _shareWithPartner();
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Set to Home Widget'),
              onTap: () {
                Navigator.pop(context);
                _updateHomeWidget();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareWithPartner() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final String? deviceID = await asyncPrefs.getString(deviceIDKey);

    await Client.makePostRequest(countdownURL, {
      "sender_id": deviceID,
      "countdown_id": widget.countdown.id,
      "title": widget.countdown.title,
      "end_date": widget.countdown.enddate.toString(),
      "completed": widget.countdown.completed
    }, context.mounted == true ? context : null);
  }

  void _updateHomeWidget() {
    HomeWidget.saveWidgetData<String>('countdown_title', widget.countdown.title);
    String duration = _formatDuration();
    HomeWidget.saveWidgetData<String>('countdown_duration', duration);
    HomeWidget.updateWidget(androidName: widgetName);
  }
}
