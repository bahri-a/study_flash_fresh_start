import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//Name der subject Datei
part 'subject.freezed.dart';
part 'subject.g.dart';

// --- HELFER-FUNKTIONEN (STATT KLASSE) ---
// Diese wandeln den Timestamp einfach direkt um
DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();
Timestamp _toJson(DateTime date) => Timestamp.fromDate(date);

@freezed
abstract class Subject with _$Subject {
  const factory Subject({
    //Todo: Weitere Variablen im Verlauf hinzufügen
    required String subjectName,
    required String id,
    //required String farbe,

    // Das sagt: "Nimm _fromJson zum Lesen und _toJson zum Schreiben"
    @JsonKey(fromJson: _fromJson, toJson: _toJson) required DateTime createdAt,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}
