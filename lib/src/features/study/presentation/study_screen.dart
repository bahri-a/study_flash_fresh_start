import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/src/core/providers/flashcard_provider.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';
import 'package:study_flash/src/features/study/presentation/widgets/flashcard_view.dart';
import 'package:study_flash/src/features/study/presentation/widgets/show_add_flashcard_dialog.dart';

class StudyScreen extends ConsumerWidget {
  final String subjectId;
  final String topicId;
  const StudyScreen({super.key, required this.subjectId, required this.topicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (subjectId: subjectId, topicId: topicId);
    final asyncFlashcards = ref.watch(flashcardListProvider(params));
    final currentTopic = ref.watch(currentTopicProvider(params));

    return Scaffold(
      appBar: AppBar(
        title: currentTopic.when(
          data: (topic) {
            return Text("Study $topic");
          },
          error: (error, stackTrace) => Text("Study"),
          loading: () => Text("Study"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showAddFlashcardDialog(context, ref, params),
          ),
        ],
      ),
      body: asyncFlashcards.when(
        data: (flashcards) {
          if (flashcards.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.push("/addFlashcardScreen/$subjectId/$topicId");
                },
                child: Text("Erstes Flashcard hinzufügen"),
              ),
            );
          }
          return PageView.builder(
            itemCount: flashcards.length,
            itemBuilder: (context, index) {
              final card = flashcards[index];
              return FlashcardView(flashcard: card);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Fehler: $err")),
      ),
    );
  }
}
