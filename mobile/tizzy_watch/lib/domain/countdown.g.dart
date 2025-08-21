// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Countdown _$CountdownFromJson(Map<String, dynamic> json) => _Countdown(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  enddate: DateTime.parse(json['enddate'] as String),
  completed: json['completed'] as bool? ?? false,
);

Map<String, dynamic> _$CountdownToJson(_Countdown instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'enddate': instance.enddate.toIso8601String(),
      'completed': instance.completed,
    };
