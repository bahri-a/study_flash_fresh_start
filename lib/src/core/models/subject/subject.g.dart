// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subject _$SubjectFromJson(Map<String, dynamic> json) => _Subject(
  subject: json['subject'] as String,
  createdAt: _fromJson(json['createdAt'] as Timestamp),
);

Map<String, dynamic> _$SubjectToJson(_Subject instance) => <String, dynamic>{
  'subject': instance.subject,
  'createdAt': _toJson(instance.createdAt),
};
