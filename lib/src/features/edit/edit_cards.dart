import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';
import 'package:study_flash/src/core/providers/flashcard_provider.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';
import 'package:study_flash/src/features/edit/widgets/flashcard_view_for_edit.dart';
import 'package:study_flash/src/features/study/presentation/widgets/study_screen_widgets/icons_for_flashcard.dart';
import 'package:study_flash/src/features/study/presentation/widgets/show_add_flashcard_dialog.dart';

class EditCards extends ConsumerStatefulWidget {
  final String subjectId;
  final String topicId;

  const EditCards({super.key, required this.subjectId, required this.topicId});

  @override
  ConsumerState<EditCards> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<EditCards> {
  final pageController = PageController(viewportFraction: 0.97);

  int _currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // Öffnen des Bearbeiten-Dialogs
  void _showEditDialog(BuildContext context, Flashcard flashcard) {
    final frontController = TextEditingController(
      text: flashcard.front,
    ); // erhält den bereits vorhanden flashcard.front-Text, damit der Nutzer ihn bearbeiten kann
    final backController = TextEditingController(text: flashcard.back);
    final params = (subjectId: widget.subjectId, topicId: widget.topicId);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Karte bearbeiten"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: frontController,
                decoration: const InputDecoration(labelText: "Vorderseite"),
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: backController,
                decoration: const InputDecoration(labelText: "Rückseite"),
                maxLines: 1,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Abbrechen")),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(flashcardrepositoryProvider(params))
                    .updateFlashcard(
                      flashcardId: flashcard.id,
                      front: frontController.text,
                      back: backController.text,
                    );
                ref.invalidate(flashcardListProvider(params));
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Speichern"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final params = (subjectId: widget.subjectId, topicId: widget.topicId);

    final currentTopic = ref.watch(currentTopicProvider(params));
    final asyncFlashcards = ref.watch(flashcardListProvider(params));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: currentTopic.when(
          data: (topic) {
            return Text("Edit $topic");
          },
          error: (error, stackTrace) => Text("Edit"),
          loading: () => Text("Edit"),
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
                  context.push("/addFlashcardScreen/${widget.subjectId}/${widget.topicId}");
                },
                child: Text("Erstes Flashcard hinzufügen"),
              ),
            );
          }
          return Align(
            alignment: Alignment(0, -0.5),
            child: Column(
              mainAxisSize: .min,
              children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: flashcards.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final card = flashcards[index];
                      return FlashcardViewForEditScreen(flashcard: card);
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        final currentCard = flashcards[_currentIndex];
                        _showEditDialog(context, currentCard);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Fehler: $err")),
      ),
    );
  }
}
