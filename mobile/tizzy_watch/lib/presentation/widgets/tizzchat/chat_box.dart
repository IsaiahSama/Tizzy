import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/providers/messages_provider.dart';
import 'package:tizzy_watch/domain/tempo_message.dart';

class ChatBox extends ConsumerStatefulWidget {
  const ChatBox({super.key});

  @override
  ConsumerState<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends ConsumerState<ChatBox> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollToBottom();
    
    List<TempoMessage> messages = ref.watch(messagesProvider);

    if (messages.isEmpty) {
      return Center(child: Text("No messages yet"));
    }
    return Expanded(
      child: ListView.builder(
        controller: _controller,
        itemCount: messages.length,
        prototypeItem: ListTile(title: Text(messages.first.message), tileColor: messages.first.color),
        itemBuilder: (context, idx) => ListTile(title: Text(messages[idx].message), tileColor: messages[idx].color),
      ),
    );
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
