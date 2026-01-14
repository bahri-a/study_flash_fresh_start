import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';
import 'package:study_flash/src/features/study/presentation/widgets/show_add_topic_dialog.dart';

class StudytopicsScreen extends ConsumerWidget {
  final String subjectId;
  const StudytopicsScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTopics = ref.watch(topicsListProvider(subjectId));
    final asyncCurrentSubject = ref.watch(currentSubjectProvider(subjectId));
    final topicRepository = ref.watch(topicRepositoryProvider(subjectId));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTopicDialog(context, ref, subjectId);
        },
        child: Icon(Icons.add, color: Colors.black, fontWeight: FontWeight.w500, size: 28),
      ),
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
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Card(
                    color: Colors.blue.shade100,
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ListTile(
                      onTap: () {
                        context.push("/study/$subjectId/${topic.id}");
                      },
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(
                        topic.topicName,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      // subtitle: data.length == 1
                      //     ? Text("${FlashCard-Anzahl} Card")
                      //     : Text("${FlashCard-Anzahl} Cards"), //!todo
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent.withAlpha(120),
                        child: const Icon(Icons.vibration),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          ref.read(topicRepositoryProvider(subjectId)).deleteTopic(topic.id);

                          ref.invalidate(topicsListProvider(subjectId));
                        },
                        icon: const Icon(Icons.delete_forever_rounded),
                      ),
                      iconColor: Colors.red,
                    ),
                  ),
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
