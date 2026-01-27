import 'package:freezed_annotation/freezed_annotation.dart';

part 'flashcard.freezed.dart';
part 'flashcard.g.dart';

@freezed
abstract class Flashcard with _$Flashcard {
  const factory Flashcard({
    required String id,
    required String front,
    required String back,

    @Default(0) int rating,
  }) = _Flashcard;

  factory Flashcard.fromJson(Map<String, dynamic> json) => _$FlashcardFromJson(json);
}
