import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PresenceIndicatorInfo extends StatelessWidget {
  const PresenceIndicatorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
              Icon(LucideIcons.heart, size: 15),
              const Text("Online"),

        ],),
        Row(children: [
                Icon(LucideIcons.heartOff, size: 15),
                const Text("Offline"),
        ],),

      ]
    );
  }
}