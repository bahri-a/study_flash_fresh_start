import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:study_flash/constants/Widgets/drawer_menu.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';
import 'package:study_flash/src/core/repositories/subject_repository.dart';
import 'package:study_flash/src/features/study/presentation/widgets/show_add_topic_dialog.dart';

class Studytopics extends ConsumerWidget {
  final String subjectId;
  Studytopics({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTopics = ref.watch(topicsListProvider(subjectId));
    final asyncCurrentSubject = ref.watch(currentSubjectProvider(subjectId));

    return Scaffold(
      appBar: AppBar(
        title: asyncCurrentSubject.when(
          data: (currentSubject) => Text("Topics für ${currentSubject?.subjectName}"),
          error: (error, stackTrace) => Text("Topics"),
          loading: () => Text(""),
        ),
      ),
      body: asyncTopics.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: ElevatedButton.icon(
                label: asyncCurrentSubject.when(
                  data: (currentSubject) =>
                      Text("Erstes Topic für ${currentSubject?.subjectName} erstellen"),
                  error: (error, stackTrace) => Text("Erstes Topic erstellen"),
                  loading: () => Text(""),
                ),
                icon: Icon(Icons.add),
                onPressed: () {
                  showAddTopicDialog(context, ref, subjectId);
                },
              ),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final topic = data[index];
                return ListTile(
                  title: Text(topic.topicName),
                  trailing: IconButton(
                    onPressed: () async {
                      ref.read(topicRepositoryProvider(subjectId)).deleteTopic(topic.id);

                      ref.invalidate(topicsListProvider(subjectId));
                    },
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                  iconColor: Colors.red,
                );
              },
            );
          }
        },
        error: (error, stackTrace) {
          return Center(child: Text("Fehler beim Laden: $error"));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
