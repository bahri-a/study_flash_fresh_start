import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flashcard.freezed.dart';
part 'flashcard.g.dart';

@freezed
abstract class Flashcard with _$Flashcard {
  const factory Flashcard({
    required String id,
    required String front,
    required String back,
    // Später:
    // required bool isCorrect,
    // required DateTime lastLearned,
  }) = _Flashcard;

  factory Flashcard.fromJson(Map<String, dynamic> json) => _$FlashcardFromJson(json);
}
