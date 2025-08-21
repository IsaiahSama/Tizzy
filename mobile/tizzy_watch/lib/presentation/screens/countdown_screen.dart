import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/providers/countdown_provider.dart';
import 'package:tizzy_watch/presentation/widgets/app_bar.dart';
import 'package:tizzy_watch/presentation/widgets/app_drawer.dart';
import 'package:tizzy_watch/presentation/widgets/countdown/countdown_widget.dart';
import 'package:tizzy_watch/presentation/widgets/countdown/new_countdown_modal.dart';

class CountdownScreen extends ConsumerWidget {
  const CountdownScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdowns = ref.watch(countdownsProvider);

    return Scaffold(
      appBar: MyAppBar(title: "Love Timers"),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const NewCountdownModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: countdowns.when(
          data: (countdowns) {
            if (countdowns.isEmpty) {
              return const Center(child: Text("No countdowns available"));
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: countdowns.length,
                    itemBuilder: (context, index) {
                      return CountdownWidget(countdown: countdowns[index]);
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stack) =>
                  Center(child: Text('Error: \\${error.toString()}')),
        ),
      ),
    );
  }
}
