import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';
import 'package:study_flash/src/features/home/presentation/widgets/grid_view_subjects.dart';
import 'package:study_flash/src/features/home/presentation/widgets/home_header.dart';
import 'package:study_flash/src/features/home/presentation/widgets/progress_balken.dart';
import 'package:study_flash/src/features/home/presentation/widgets/show_add_subject_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsList = ref.watch(subjectsListProvider);

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
      body: Column(
        children: [
          HomeHeader(),
          SizedBox(height: 10),
          //ProgressBalken(),
          SizedBox(height: 10),
          GridViewSubjects(),
        ],
      ),
    );
  }
}
