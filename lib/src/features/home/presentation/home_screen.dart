import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/subject_provider.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';
import 'package:study_flash/src/features/home/presentation/widgets/grid_view_subjects.dart';
import 'package:study_flash/src/features/home/presentation/widgets/create_box.dart';
import 'package:study_flash/src/features/home/presentation/widgets/home_header.dart';
import 'package:study_flash/src/features/home/presentation/widgets/progress_balken.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          ProgressBalken(),
          GridViewSubjects(),
        ],
      ),
    );
  }
}
