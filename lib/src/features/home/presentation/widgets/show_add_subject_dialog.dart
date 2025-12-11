import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/subject_provider.dart';

void showAddSubjectDialog(BuildContext context, WidgetRef ref) {
  final TextEditingController subjectController = TextEditingController();
  final subjectFunktionen = ref.read(subjectRepositoryProvider);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Neues Fach erstellen"),
        content: TextField(
          controller: subjectController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "z.B. Arabisch",
            labelText: "Fach",
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              try {
                subjectFunktionen.addSubject(
                  subjectName: subjectController.text,
                );
                Navigator.of(context).pop();
                ref.invalidate(subjectsListProvider);
              } catch (e) {
                throw Exception("Unerwarteter Fehler: $e");
              }
            },
            child: const Text("Hinzufügen"),
          ),
        ],
      );
    },
  );
}
