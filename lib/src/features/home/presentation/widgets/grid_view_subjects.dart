import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/subject_provider.dart';
import 'package:study_flash/src/features/home/presentation/widgets/create_box.dart';
import 'package:study_flash/src/features/home/presentation/widgets/show_add_subject_dialog.dart';

class GridViewSubjects extends ConsumerWidget {
  GridViewSubjects({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsData = ref.watch(subjectsListProvider);

    return Expanded(
      flex: 1,
      child: subjectsData.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: ElevatedButton.icon(
                label: const Text("Erstes Fach erstellen"),
                icon: Icon(Icons.add),
                onPressed: () {
                  showAddSubjectDialog(context, ref);
                },
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  final currentSubject = data[index];
                  return CreateBox(name: currentSubject.subjectName);
                },
              ),
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
