import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tizzy_watch/core/auth.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  const MyAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      actions: [IconButton(onPressed: () async{
        await AuthService.clearUser();
        if(context.mounted) context.go('/register');
      }, icon: const Icon(Icons.delete))],
    );
  }
}
