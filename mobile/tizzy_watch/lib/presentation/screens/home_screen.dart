import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/client.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/presentation/widgets/home/heart.dart';
import 'package:tizzy_watch/presentation/widgets/home/presence_indicator.dart';
import 'package:tizzy_watch/presentation/widgets/home/presence_indicator_info.dart';
import 'package:tizzy_watch/presentation/widgets/home/watch_stats.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Client.promptServer();
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
            Heart(),
            WatchStats(),
          ],
        ),
      ),
    );
  }
}
