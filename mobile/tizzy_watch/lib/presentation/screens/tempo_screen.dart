import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/domain/entities/tempo_message.dart';
import 'package:tizzy_watch/presentation/widgets/tempo/tempo_message_widget.dart';


List<TempoMessage> messages = [
  TempoMessage(content: "Tempo", color: Colors.red),
  TempoMessage(content: "I miss you!", color: Colors.green),
  TempoMessage(content: "Checkin in~", color: Colors.blue),
  TempoMessage(content: "Stay Safe", color: Colors.orange),
  TempoMessage(content: "Check Phone!", color: Colors.purple),
  TempoMessage(content: "Call?", color: Colors.yellow),
  TempoMessage(content: "I want you!", color: Colors.pink),
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
                onPressed: () {
                  // Add button press handling logic here
                  String value = ref.read(customTextProvider.notifier).state;
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
