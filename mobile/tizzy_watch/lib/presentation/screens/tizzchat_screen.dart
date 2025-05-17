import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TizzChatScreen extends ConsumerWidget {
  const TizzChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TizzChat Screen'),
      ),
      body: const Center(
        child: Text('This is the TizzChat screen'),
      ),
    );
  }
}
