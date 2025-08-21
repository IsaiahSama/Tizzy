import 'package:freezed_annotation/freezed_annotation.dart';

part 'countdown.freezed.dart';
part 'countdown.g.dart';

@freezed
abstract class Countdown with _$Countdown {

  const factory Countdown({
    required int id,
    required String title,
    required DateTime enddate,
    @Default(false) bool completed,
  }) = _Countdown;

  factory Countdown.fromJson(Map<String, dynamic> json) => _$CountdownFromJson(json);
}