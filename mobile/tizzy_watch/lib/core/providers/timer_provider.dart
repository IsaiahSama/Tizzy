import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tizzy_watch/data/repositories/timer_repository.dart';
import 'package:tizzy_watch/domain/timer.dart';

part 'timer_provider.g.dart';

@Riverpod(keepAlive: true)
class TimerProvider extends _$TimerProvider {
  final repository = TimerRepositoryPref();

  @override
  Future<List<Timer>> build() async {
    return repository.getAllTimers();
  }

  Future<void> addTimer(Timer timer) async {
    state = state.whenData((timers) => [...timers, timer]);
  }

  Future<void> updateTimerCompletion(int timerID, bool completed) async {
    state = state.whenData(
      (timers) =>
          timers.map((timer) {
            if (timer.id == timerID) {
              return timer.copyWith(completed: completed);
            }
            return timer;
          }).toList(),
    );

    state.whenData((timers) => repository.saveTimers(timers));
  }

  Future<void> deleteTimer(int timerID) async {
    state = state.whenData(
      (timers) => timers.where((timer) => timer.id != timerID).toList(),
    );

    state.whenData((timers) => repository.saveTimers(timers));
  }
}
