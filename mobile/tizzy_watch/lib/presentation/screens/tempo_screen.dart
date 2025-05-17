import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';


class TempoScreen extends ConsumerWidget {
  const TempoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar(title: "Tempo"),
      drawer: AppDrawer(),
      body: const Center(
        child: Text('This is the Tempo screen'),
      ),
    );
  }
}
