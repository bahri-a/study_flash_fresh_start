// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Topic _$TopicFromJson(Map<String, dynamic> json) => _Topic(
  topicName: json['topicName'] as String,
  id: json['id'] as String,
  createdAt: _fromJson(json['createdAt'] as Timestamp),
);

Map<String, dynamic> _$TopicToJson(_Topic instance) => <String, dynamic>{
  'topicName': instance.topicName,
  'id': instance.id,
  'createdAt': _toJson(instance.createdAt),
};
