// BOILERPLATE BOILERPLATE BOILERPLATE

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/repositories/auth_repository.dart';

// Dieser Provider stellt das Repository für die ganze App bereit.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

// Dieser Provider "hört" auf den Login-Status.
// Die UI kann das hier watchen, um zu wissen: Ist der User eingeloggt?
// Gibt zurück: AsyncValue<User?>
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});
