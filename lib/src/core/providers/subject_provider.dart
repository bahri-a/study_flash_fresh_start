import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/src/core/services/core_service.dart';
import 'package:study_flash/src/core/repositories/subject_repository.dart';

//Liefert uns eine Instanz der Klasse "SubjectRepository".
//Stellt sicher, dass wir von überall aus auf die Methoden dieses Repos zugreifen können
//Diese Methoden sind z.B.: addSubjects, getSubjects
//!* Die UI nutzt diesen Provider, um bei Buttonklicks diese Methoden aufzurufen
final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  final coreService = ref.watch(coreServiceProvider);
  final authRepo = ref.watch(authRepositoryProvider);
  return SubjectRepository(coreService, authRepo);
});

//Dieser Provider liefert mir Daten für die UI.
final subjectsListProvider = FutureProvider<List<Subject>>((ref) async {
  //aktualisiert, wenn User sich ab- anmeldet.
  final userState = ref.watch(authStateChangesProvider);
  if (userState.value == null) return [];

  final repository = ref.watch(subjectRepositoryProvider);
  return repository.getSubjects();
});

final currentSubjectProvider = FutureProvider.family<Subject?, String>((ref, subjectId) {
  final subjectRepository = ref.watch(subjectRepositoryProvider);
  return subjectRepository.getCurrentSubject(subjectId: subjectId);
});
