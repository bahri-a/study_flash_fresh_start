import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/auth_provider.dart';
import 'package:study_flash/repositories/auth_repository.dart';
import 'package:study_flash/services/core_service.dart';
import 'package:study_flash/repositories/subject_repository.dart';
import 'package:study_flash/repositories/app_user_repository.dart';
import 'package:study_flash/core/models/app_user/app_user.dart';

final userRepositoryProvider = Provider<AppUserRepository>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AppUserRepository(CoreService(), authRepository);
});

final currentUserDataProvider = StreamProvider<AppUser?>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.streamCurrentAppUserData();
});
