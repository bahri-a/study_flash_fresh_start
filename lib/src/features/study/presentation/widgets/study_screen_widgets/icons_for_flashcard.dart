import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';
import 'package:study_flash/src/core/providers/flashcard_provider.dart';

//!todo NEXT: Flashcard rating rated die Karte davor. Das muss ich irgendwie anders lösen mit den onTap.

class IconsForFlashcard extends ConsumerWidget {
  final Flashcard flashcard;
  final String subjectId;
  final String topicId;
  final PageController controller;
  const IconsForFlashcard({
    super.key,
    required this.subjectId,
    required this.topicId,
    required this.controller,
    required this.flashcard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (subjectId: subjectId, topicId: topicId);
    final flashcardRepository = ref.watch(flashcardrepositoryProvider(params));

    final flashcardId = flashcard.id;
    int currentRating = flashcard.rating;

    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          // DAUMEN RUNTER
          InkWell(
            child: Icon(Icons.thumb_down, color: Colors.red, size: 60),
            onTap: () async {
              // bewusst ohne await
              flashcardRepository.updateRating(flashcardId: flashcardId, newRating: 0);

              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          // DAUMEN HOCH
          InkWell(
            child: Icon(Icons.thumb_up, color: Colors.green, size: 60),
            onTap: () async {
              flashcardRepository.updateRating(
                flashcardId: flashcardId,
                newRating: currentRating < 6 ? currentRating + 1 : currentRating,
              );
              //ref.invalidate(flashcardListProvider(params));
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
