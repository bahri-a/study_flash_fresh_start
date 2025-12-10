import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/subject_provider.dart';
import 'package:study_flash/src/features/home/presentation/widgets/create_box.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsListProvider);

    return Scaffold(
      body: subjects.when(
        data: (subjects) {
          if (subjects.isEmpty) {
            return const Center(child: Text("Keine Fächer gefunden"));
          }
          return GridView.builder(
            itemCount: subjects.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                ),
            itemBuilder: (context, index) {
              final currentSubject = subjects[index];
              return CreateBox(name: currentSubject.subject);
            },
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
