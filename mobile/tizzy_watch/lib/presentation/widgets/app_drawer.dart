import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Tizzy Watch Applications',
                style: TextStyle(color: Colors.white, fontSize: 34)),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              context.goNamed('Profile');
            },
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              context.goNamed('Home');
            },
          ),
          ListTile(
            title: Text('Tempo'),
            onTap: () {
              context.goNamed('Tempo');
            },
          ),
          ListTile(
            title: Text('ISeeYou'),
            onTap: () {
              context.goNamed('ISeeYou');
            },
          ),
          ListTile(
            title: Text('TizzChat'),
            onTap: () {
              context.goNamed('TizzChat');
            },
          ),
        ],
      ),
    );
  }
}
