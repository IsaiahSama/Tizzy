import 'package:flutter/material.dart';
import 'package:tizzy_watch/application/gadget_bridge_service.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final List<Widget>? actions;

  const MyAppBar({super.key, required this.title, this.actions})
    : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await GadgetBridgeService.sendUserID(null);
          },
          icon: const Icon(Icons.sync),
        ),
        ...actions ?? [],
      ],
    );
  }
}
