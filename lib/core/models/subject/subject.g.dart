// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subject _$SubjectFromJson(Map<String, dynamic> json) => _Subject(
  subjectName: json['subjectName'] as String,
  createdAt: _fromJson(json['createdAt'] as Timestamp),
);

Map<String, dynamic> _$SubjectToJson(_Subject instance) => <String, dynamic>{
  'subjectName': instance.subjectName,
  'createdAt': _toJson(instance.createdAt),
};
