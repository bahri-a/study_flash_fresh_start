import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/models/topic/topic.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/src/core/repositories/auth_repository.dart';
import 'package:study_flash/src/core/repositories/topic_repository.dart';
import 'package:study_flash/src/core/services/core_service.dart';

// Provider mit .family:
// <TopicRepository, String> bedeutet: Er baut ein TopicRepository und erwartet von außen die SubjectId als String
final topicRepositoryProvider = Provider.family<TopicRepository, String>((
  ref,
  subjectId,
) {
  final coreService = ref.watch(coreServiceProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return TopicRepository(coreService, authRepository, subjectId);
});

//
// ----------------
//

final topicsListProvider = FutureProvider.family<List<Topic>, String>((
  ref,
  subjectId,
) async {
  final userState = ref.watch(authStateChangesProvider);
  if (userState.value == null) return [];

  final repository = ref.watch(topicRepositoryProvider(subjectId));
  return repository.getTopics();
});
