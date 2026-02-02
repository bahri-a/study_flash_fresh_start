import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/src/core/repositories/charts_repository.dart';

//
// ____________________
//

final chartsRepositoryProvider = Provider<ChartsRepository>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return ChartsRepository(userId: authRepo.currentUser?.uid ?? '');
});

//
// ____________________
//

final allFlashcardsOfUser = FutureProvider<List<Flashcard>>((ref) async {
  final repository = ref.watch(chartsRepositoryProvider);
  return repository.getAllFlashcardsOfUser();
});

//
// ____________________
//

final highRatedCards = Provider<AsyncValue<int>>((ref) {
  final asyncCards = ref.watch(allFlashcardsOfUser);

  return asyncCards.whenData((cards) {
    return cards.where((card) => card.rating >= 3).length;
  });
});

//
// ____________________
//

final lowRatedCards = Provider<AsyncValue<int>>((ref) {
  final asyncCards = ref.watch(allFlashcardsOfUser);

  return asyncCards.whenData((cards) {
    return cards.where((card) => card.rating < 3 && card.rating > 0).length;
  });
});

//
// ____________________
//

final statsPercentage = Provider<AsyncValue<List<double>>>((ref) {
  final asyncHigh = ref.watch(highRatedCards);
  final asyncLow = ref.watch(lowRatedCards);

  if (asyncHigh.isLoading || asyncLow.isLoading) {
    return const AsyncLoading(); //AsyncLoading();
  }

  final high = asyncHigh.value ?? 0;
  final low = asyncLow.value ?? 0;

  final total = high + low;

  if (total == 0) {
    return const AsyncData([0.0, 0.0]);
  }

  return AsyncData([high / total, low / total]);
});
