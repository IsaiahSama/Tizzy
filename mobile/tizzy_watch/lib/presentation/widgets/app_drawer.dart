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
              color: Colors.deepPurple,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text('Tizzy Apps',
                  style: TextStyle(color: Colors.white, fontSize: 34)),
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              context.goNamed('Profile');
            },
          ),
          ListTile(
            title: Text('Stats'),
            onTap: () {
              context.goNamed('Stats');
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
