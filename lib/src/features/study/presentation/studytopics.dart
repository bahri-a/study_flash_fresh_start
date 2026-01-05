import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/constants/Widgets/drawer_menu.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';

class Studytopics extends ConsumerWidget {
  const Studytopics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subject = ref.read(subjectRepositoryProvider);

    final bool showFloatingButton = subjectsList.maybeWhen(
      data: (data) => data.isNotEmpty,
      orElse: () => false,
    );

    return Scaffold(
      floatingActionButton: showFloatingButton
          ? FloatingActionButton(
              onPressed: () {
                showAddSubjectDialog(context, ref);
              },
              child: const Icon(Icons.add),
            )
          : null,
      appBar: AppBar(title: Text("Topics")),
      body: Center(child: Text("No topics found")),
    );
  }
}
