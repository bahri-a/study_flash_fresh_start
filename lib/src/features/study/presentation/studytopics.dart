import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/constants/Widgets/drawer_menu.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';

class Studytopics extends ConsumerWidget {
  const Studytopics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subject = ref.read(subjectRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Topics")),
      body: Center(child: Text("No topics found")),
    );
  }
}
