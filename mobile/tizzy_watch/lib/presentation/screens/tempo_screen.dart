import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/client.dart';
import 'package:tizzy_watch/core/constants.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/domain/entities/tempo_message.dart';
import 'package:tizzy_watch/presentation/widgets/tempo/tempo_message_widget.dart';
import "package:tizzy_watch/core/auth.dart";

List<TempoMessage> messages = [
  TempoMessage(
    message: "Tempo",
    color: const Color.fromARGB(255, 141, 32, 188),
  ),
  TempoMessage(
    message: "I miss you!",
    color: const Color.fromARGB(255, 184, 27, 184),
  ),
  TempoMessage(message: "Checkin in~", color: Colors.blue),
  TempoMessage(
    message: "Stay Safe",
    color: const Color.fromARGB(255, 0, 163, 163),
  ),
  TempoMessage(
    message: "Check Phone!",
    color: const Color.fromARGB(255, 23, 164, 61),
  ),
  TempoMessage(message: "Call?", color: const Color.fromARGB(255, 218, 125, 4)),
  TempoMessage(
    message: "I want you!",
    color: const Color.fromARGB(255, 227, 31, 77),
  ),
];

final textControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

class TempoScreen extends ConsumerWidget {
  const TempoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = ref.watch(textControllerProvider);
    return Scaffold(
      appBar: MyAppBar(title: "Tempo"),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 25.0, 8.0, 8.0),
              child: Text(
                'Quick! Send a message!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (context, index) => TempoMessageWidget(
                message: messages[index],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 15.0),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter custom message',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.deepPurple),
                  ),
                  onPressed: () async {
                    TempoMessage msg = TempoMessage(
                      message: textController.text,
                      color: Colors.purple,
                    );
                    // await GadgetBridgeService.sendTempoMesssage(msg);
                    final formData = FormData.fromMap({
                      "message": msg.message,
                      "sender_id": await AuthService.getDeviceID(),
                      "color": "blue",
                    });
                    await ref
                        .read(dioProvider)
                        .post(notifyURL, data: formData);

                    textController.clear();
                  },
                  child: Text('Send Message'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

