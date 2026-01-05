import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.freezed.dart';
part 'topic.g.dart';

@freezed
abstract class Topic with _$Topic {
  const factory Topic({
    required String topicName,
    required String id,

    // Das sagt: "Nimm _fromJson zum Lesen und _toJson zum Schreiben"
    @JsonKey(fromJson: _fromJson, toJson: _toJson) required DateTime createdAt,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}

// Hilfsfunktionen
DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();
Timestamp _toJson(DateTime date) => Timestamp.fromDate(date);
