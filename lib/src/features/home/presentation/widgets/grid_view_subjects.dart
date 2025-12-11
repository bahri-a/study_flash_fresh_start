import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/subject_provider.dart';
import 'package:study_flash/src/features/home/presentation/widgets/create_box.dart';

class GridViewSubjects extends ConsumerWidget {
  GridViewSubjects({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsDaten = ref.watch(subjectsListProvider);

    return Expanded(
      flex: 1,
      child: subjectsDaten.when(
        data: (data) {
          if (data.isEmpty) {
            //todo: Statt "Keine Fächer gefunden" ein Add-Button hinzufügen
            return const Center(child: Text("Keine Fächer gefunden"));
          }
          return Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: GridView.builder(
              itemCount: data.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                  ),
              itemBuilder: (context, index) {
                final currentSubject = data[index];
                return CreateBox(name: currentSubject.subject);
              },
            ),
          );
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
