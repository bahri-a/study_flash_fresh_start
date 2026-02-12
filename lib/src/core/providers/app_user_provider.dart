import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/src/core/services/core_service.dart';
import 'package:study_flash/src/core/repositories/app_user_repository.dart';
import 'package:study_flash/src/core/models/app_user/app_user.dart';

final userRepositoryProvider = Provider<AppUserRepository>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AppUserRepository(CoreService(), authRepository);
});

final currentUserDataProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.streamCurrentAppUserData();
});
