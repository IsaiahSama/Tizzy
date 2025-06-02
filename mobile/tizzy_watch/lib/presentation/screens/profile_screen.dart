import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/auth.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar(title: "Profile"),
      drawer: AppDrawer(),
      body: FutureBuilder<String?>(
        future: AuthService.getDeviceID(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                SelectableText("Device ID: ${snapshot.data!}"),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    final data = ClipboardData(text: snapshot.data!);
                    Clipboard.setData(data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
