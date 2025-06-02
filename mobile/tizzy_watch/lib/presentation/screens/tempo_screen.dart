import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/client.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/domain/entities/tempo_message.dart';
import 'package:tizzy_watch/presentation/widgets/tempo/tempo_message_widget.dart';
import "package:tizzy_watch/core/auth.dart";


List<TempoMessage> messages = [
  TempoMessage(message: "Tempo", color: Colors.red),
  TempoMessage(message: "I miss you!", color: Colors.green),
  TempoMessage(message: "Checkin in~", color: Colors.blue),
  TempoMessage(message: "Stay Safe", color: Colors.orange),
  TempoMessage(message: "Check Phone!", color: Colors.purple),
  TempoMessage(message: "Call?", color: Colors.yellow),
  TempoMessage(message: "I want you!", color: Colors.pink),
];

final customTextProvider = StateProvider<String>((ref) => '');

class TempoScreen extends ConsumerWidget {
  const TempoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar(title: "Tempo"),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:[
          Text('Quick! Send a message!'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (context, index) => TempoMessageWidget(message: messages[index]),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter custom message',
                  ),
                  onChanged: (text) {
                    ref.read(customTextProvider.notifier).state = text;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  TempoMessage msg = TempoMessage(message: ref.read(customTextProvider.notifier).state, color: Colors.purple);
                  // await GadgetBridgeService.sendTempoMesssage(msg);
                  final formData = FormData.fromMap({"message": msg.message, "sender_id": await AuthService.getDeviceID(), "color": "blue"});
                  await ref.read(dioProvider).post("/tempo/notify", data: formData);

                },
                child: Text('Send Message'),
              ),
            ],
          ),
        ]
      )
    );
  }
}
