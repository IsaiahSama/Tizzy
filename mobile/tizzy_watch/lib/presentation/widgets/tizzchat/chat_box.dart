import "package:flutter/material.dart";

List<String> messages = List<String>.generate(20, (index) => "Message $index");

class ChatBox extends StatelessWidget {
  ChatBox({super.key});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollToBottom();
    return Expanded(
      child: ListView.builder(
        controller: _controller,
        itemCount: messages.length,
        prototypeItem: ListTile(title: Text(messages.first)),
        itemBuilder: (context, idx) => ListTile(title: Text(messages[idx])),
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
