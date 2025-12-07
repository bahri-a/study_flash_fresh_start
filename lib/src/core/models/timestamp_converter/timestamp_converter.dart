// timestamp_converter.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

// Wir definieren eine Klasse, die weiss, wie man Timestamps umwandelt
class TimestampConverter
    implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  // Von Firestore (Timestamp) zu Dart (DateTime)
  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  // Von Dart (DateTime) zu Firestore (Timestamp)
  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date);
  }
}
