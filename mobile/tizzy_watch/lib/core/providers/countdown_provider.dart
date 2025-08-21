import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tizzy_watch/data/repositories/countdown_repository.dart';
import 'package:tizzy_watch/domain/countdown.dart';

part 'countdown_provider.g.dart';

@Riverpod(keepAlive: true)
class Countdowns extends _$Countdowns {
  final repository = CountdownRepositoryPref();

  @override
  Future<List<Countdown>> build() async {
    return repository.getAllCountdowns();
  }

  Future<void> addCountdown(Countdown countdown) async {
    state = state.whenData((countdowns) => [...countdowns, countdown]);
    state.whenData((countdowns) => repository.saveCountdowns(countdowns));
  }

  Future<void> updateCountdownCompletion(int countdownID, bool completed) async {
    state = state.whenData(
      (countdowns) =>
          countdowns.map((countdown) {
            if (countdown.id == countdownID) {
              return countdown.copyWith(completed: completed);
            }
            return countdown;
          }).toList(),
    );

    state.whenData((countdowns) => repository.saveCountdowns(countdowns));
  }

  Future<void> deleteCountdown(int countdownID) async {
    state = state.whenData(
      (countdowns) => countdowns.where((countdown) => countdown.id != countdownID).toList(),
    );

    state.whenData((countdowns) => repository.saveCountdowns(countdowns));
  }
}
