import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:tizzy_watch/core/auth.dart";
import "package:tizzy_watch/core/client.dart";
import "package:tizzy_watch/domain/entities/tempo_message.dart";

class TempoMessageWidget extends ConsumerWidget {
  final TempoMessage message;
  const TempoMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: message.color,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () async{
          // await GadgetBridgeService.sendTempoMesssage(message);
          final formData = FormData.fromMap({"message": message.message, "sender_id": await AuthService.getDeviceID(), "color": "blue"});
          await ref.read(dioProvider).post("/notify", data: formData);
        },
        child: Text(message.message, style: const TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}