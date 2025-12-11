import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/auth_provider.dart';
import 'package:study_flash/services/core_service.dart';
import 'package:study_flash/src/core/data/subject_repository.dart';

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  final coreService = CoreService();
  final authRepo = ref.watch(authRepositoryProvider);
  return SubjectRepository(coreService, authRepo);
});

final subjectsListProvider = FutureProvider((ref) async {
  final repository = ref.watch(subjectRepositoryProvider);
  return repository.getSubjects();
});
