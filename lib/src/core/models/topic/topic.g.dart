// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Topic _$TopicFromJson(Map<String, dynamic> json) => _Topic(
  topicName: json['topicName'] as String,
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TopicToJson(_Topic instance) => <String, dynamic>{
  'topicName': instance.topicName,
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
};
