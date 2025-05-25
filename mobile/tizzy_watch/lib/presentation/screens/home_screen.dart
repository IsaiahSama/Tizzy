import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/presentation/widgets/home/heart.dart';
import 'package:tizzy_watch/presentation/widgets/home/presence_indicator.dart';
import 'package:tizzy_watch/presentation/widgets/home/presence_indicator_info.dart';
import 'package:tizzy_watch/presentation/widgets/home/watch_stats.dart';

final textFieldProvider = StateProvider<String>((ref) {
  return "";
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String textField = ref.watch(textFieldProvider);

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
            Row(
              children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => ref.read(textFieldProvider.notifier).state = value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a message',
                      ),
                    ),
                  ),
                ElevatedButton(onPressed: () async {
                  // await sendToBangle('Bangle.buzz();E.showMessage("Hello from Flutter!");\n');
                  if (textField != "") {
                    await sendToBangle(textField);
                  }
                }, child: Text('Send')),
              ],
            ),
            WatchStats(),
          ],
        ),
      ),
    );
  }

  Future<void> sendToBangle(String msg) async {
    AndroidIntent intent = AndroidIntent( 
      action: 'com.banglejs.uart.tx',
      package:
          'com.espruino.gadgetbridge.banglejs',
      arguments: {'line': "custom({'tempo': '$msg'})"},
    );
    await intent.sendBroadcast();
  }
}
