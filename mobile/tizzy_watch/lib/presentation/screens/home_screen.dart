import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/presentation/widgets/home/heart.dart';
import 'package:tizzy_watch/presentation/widgets/home/presence_indicator.dart';
import 'package:tizzy_watch/presentation/widgets/home/presence_indicator_info.dart';
import 'package:tizzy_watch/presentation/widgets/home/watch_stats.dart';
import 'package:tizzy_watch/data/providers/method_channel_provider.dart';

final selectedStringProvider = StateProvider<String>(
  (ref) => 'No data selected',
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void updateSelectedText(WidgetRef ref) async {
    String? data = await getSharedData();
    if (data != null) {
      ref.read(selectedStringProvider.notifier).state = data;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    updateSelectedText(ref);
    String selectedString = ref.watch(selectedStringProvider);
    return Scaffold(
      appBar: MyAppBar(title: "Home"),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [PresenceIndicator(), PresenceIndicatorInfo()],
            ),
            Text(selectedString),
            Heart(),
            WatchStats(),
          ],
        ),
      ),
    );
  }
}
