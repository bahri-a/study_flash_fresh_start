import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/src/core/providers/flashcard_provider.dart';

void showAddFlashcardDialog(BuildContext context, WidgetRef ref, FlashcardParams params) {
  final frontController = TextEditingController();
  final backController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Neue Karteikarte"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: frontController,
            decoration: const InputDecoration(labelText: "Vorderseite"),
          ),
          TextField(
            controller: backController,
            decoration: const InputDecoration(labelText: "Rückseite"),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Abbrechen")),
        ElevatedButton(
          onPressed: () async {
            await ref
                .read(flashcardrepositoryProvider(params))
                .addFlashcard(front: frontController.text, back: backController.text);

            ref.invalidate(flashcardListProvider(params));

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Speichern"),
        ),
      ],
    ),
  );
}
