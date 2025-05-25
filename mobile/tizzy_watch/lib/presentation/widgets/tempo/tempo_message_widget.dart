import "package:flutter/material.dart";
import "package:tizzy_watch/domain/entities/tempo_message.dart";

class TempoMessageWidget extends StatelessWidget {
  final TempoMessage message;
  const TempoMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: message.color,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {},
        child: Text(message.content, style: const TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}