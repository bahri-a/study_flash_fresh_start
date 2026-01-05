// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subject _$SubjectFromJson(Map<String, dynamic> json) => _Subject(
  subjectName: json['subjectName'] as String,
  id: json['id'] as String,
  createdAt: _fromJson(json['createdAt'] as Timestamp),
);

Map<String, dynamic> _$SubjectToJson(_Subject instance) => <String, dynamic>{
  'subjectName': instance.subjectName,
  'id': instance.id,
  'createdAt': _toJson(instance.createdAt),
};
