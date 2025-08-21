import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizzy_watch/domain/timer.dart';

abstract class TimerRepository {
  Future<List<Timer>> getAllTimers();
  Future<void> saveTimers(List<Timer> timers);
}

class TimerRepositoryPref implements TimerRepository {

  static const String _storageKey = 'timers';
  
  @override
  Future<List<Timer>> getAllTimers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    print(jsonString ?? "Nothing found");

    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((jsonItem) => Timer.fromJson(jsonItem)).toList();
  }
  
  @override
  Future<void> saveTimers(List<Timer> timers) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = timers.map((timer) => timer.toJson()).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

}