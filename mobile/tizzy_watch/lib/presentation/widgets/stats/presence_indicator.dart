import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PresenceIndicator extends ConsumerWidget {
  const PresenceIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Connected', style: TextStyle(fontSize: 25)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              const Text("Izzy"),
              const Text("Tity"),
            ],),
            Column(children: [
              Icon(LucideIcons.heart, size: 20),
              Icon(LucideIcons.heartOff, size: 20),
            ]),
            Column(children: [
              Text("Last Seen: Now"),
              Text("Last Seen: 17:02"),
            ])
          ],
        ),
      ],
    );
  }
}
