import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ISeeYouScreen extends ConsumerWidget {
  const ISeeYouScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ISeeYou Screen'),
      ),
      body: const Center(
        child: Text('This is the ISeeYou screen'),
      ),
    );
  }
}
