import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return Scaffold(
      appBar: MyAppBar(title: "Love Timers"),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(onPressed: () => {}, child: const Icon(Icons.add)),
      body: Padding(padding: const EdgeInsets.all(8.0),
      child: Column(
        children:[
          
        ]
      ))
    );
  }
}