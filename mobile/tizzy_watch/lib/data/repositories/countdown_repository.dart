import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tizzy_watch/domain/countdown.dart';

abstract class CountdownRepository {
  Future<List<Countdown>> getAllCountdowns();
  Future<void> saveCountdowns(List<Countdown> timers);
}

class CountdownRepositoryPref implements CountdownRepository {

  static const String _storageKey = 'timers';
  
  @override
  Future<List<Countdown>> getAllCountdowns() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    print(jsonString ?? "Nothing found");

    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((jsonItem) => Countdown.fromJson(jsonItem)).toList();
  }
  
  @override
  Future<void> saveCountdowns(List<Countdown> timers) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = timers.map((timer) => timer.toJson()).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

}