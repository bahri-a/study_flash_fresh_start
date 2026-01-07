import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';

void showAddTopicDialog(BuildContext context, WidgetRef ref, String subjectId) {
  final TextEditingController topicController = TextEditingController();
  final topicRepository = ref.read(topicRepositoryProvider(subjectId));

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Neues Topic erstellen"),
        content: TextField(
          controller: topicController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "z.B. Algebra",
            labelText: "Topic",
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await topicRepository.addTopic(topicName: topicController.text);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
                ref.invalidate(topicsListProvider(subjectId));
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
