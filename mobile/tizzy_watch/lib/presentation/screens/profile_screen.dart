import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SelectableText(
                          "Your ID: ${snapshot.data!}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        tooltip: 'Copy to clipboard',
                        onPressed: () {
                          final data = ClipboardData(text: snapshot.data!);
                          Clipboard.setData(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Copied to clipboard')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        tooltip: 'Share ID',
                        onPressed: () {
                          SharePlus.instance.share(
                            ShareParams(
                              text: snapshot.data ?? "No ID available",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await AuthService.clearUser(context);
                    if (context.mounted) context.go('/register');
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Clear User'),
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
