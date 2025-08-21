// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Timer _$TimerFromJson(Map<String, dynamic> json) => _Timer(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  enddate: DateTime.parse(json['enddate'] as String),
  completed: json['completed'] as bool? ?? false,
);

Map<String, dynamic> _$TimerToJson(_Timer instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'enddate': instance.enddate.toIso8601String(),
  'completed': instance.completed,
};
