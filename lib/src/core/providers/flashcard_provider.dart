import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/src/core/repositories/flashcard_repository.dart';
import 'package:study_flash/src/core/services/core_service.dart';

// Besondere Schreibweise ({})
typedef FlashcardParams = ({String subjectId, String topicId});

final flashcardrepositoryProvider = Provider.family<FlashcardRepository, FlashcardParams>((
  ref,
  param,
) {
  final coreService = ref.watch(coreServiceProvider);
  final authRepo = ref.watch(authRepositoryProvider);

  return FlashcardRepository(
    authRepository: authRepo,
    coreService: coreService,
    subjectId: param.subjectId,
    topicId: param.topicId,
  );
});

final flashcardListProvider = FutureProvider.family<List<Flashcard>, FlashcardParams>((ref, param) {
  final repository = ref.watch(flashcardrepositoryProvider(param));

  return repository.getFlashcards();
});
