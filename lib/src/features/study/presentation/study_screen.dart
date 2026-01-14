import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';
import 'package:study_flash/src/features/study/presentation/widgets/flashcard_view.dart';

class StudyScreen extends ConsumerWidget {
  final String subjectId;
  final String topicId;
  const StudyScreen({super.key, required this.subjectId, required this.topicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTopics = ref.watch(topicsListProvider(subjectId));

    final subject = ref.read(subjectRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Study Screen")),
      body: Center(
        child: FlashcardView(subjectId: subjectId, topicId: topicId),
      ),
    );
  }
}
