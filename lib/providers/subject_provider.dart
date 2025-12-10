import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/services/core_service.dart';
import 'package:study_flash/src/core/data/subject_repository.dart';

// "Lagerraum" für die Liste der Subjects, die uns das subject_repo gibt
// Aufgabe: Stellt dir die Funktionen von SubjectRepository zur Verfügung (getSubjects())
final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SubjectRepository(CoreService());
});

// Aufgabe: Zeigt die Liste der Fächer an
final subjectsListProvider = FutureProvider((ref) async {
  final repository = ref.watch(subjectRepositoryProvider);
  return repository.getSubjects();
});
