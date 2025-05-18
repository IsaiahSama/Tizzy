import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/presentation/widgets/tizzchat/chat_box.dart';

class TizzChatScreen extends ConsumerWidget {
  const TizzChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar(title: "TizzChat"),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ChatBox(),
            Row(children: [
              Expanded(child: TextField()),
              IconButton(onPressed: (){}, icon: const Icon(LucideIcons.heartHandshake))
            ],)
          ],
        ),
      )
    );
  }
}
