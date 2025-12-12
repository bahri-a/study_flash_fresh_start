import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/src/core/services/core_service.dart';
import 'package:study_flash/src/core/repositories/subject_repository.dart';

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  final coreService = CoreService();
  final authRepo = ref.watch(authRepositoryProvider);
  return SubjectRepository(coreService, authRepo);
});

final subjectsListProvider = FutureProvider<List<Subject>>((ref) async {
  final repository = ref.watch(subjectRepositoryProvider);
  return repository.getSubjects();
});
