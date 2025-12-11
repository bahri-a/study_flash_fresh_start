import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_flash/providers/auth_provider.dart';
import 'package:study_flash/services/core_service.dart';
import 'package:study_flash/src/core/models/app_user/app_user.dart';
import 'package:study_flash/repositories/auth_repository.dart';

class AppUserRepository {
  final CoreService _coreService;
  final AuthRepository _authRepository;

  AppUserRepository(this._coreService, this._authRepository);

  Future<void> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    final result = await _authRepository.createAccount(
      email: email,
      password: password,
      username: username,
    );
    final uid = result.user?.uid;
    if (uid == null) throw Exception("Keine UserID vorhanden");
    await _coreService.setDocument(
      path: "users",
      docId: uid,
      data: {
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<List<AppUser>> getAppUsers() async {
    final rohdaten = await _coreService.getCollection(path: 'users');
    final rohdatenDocs = rohdaten.docs;

    final users = rohdatenDocs.map((e) {
      final data = e.data();
      return AppUser.fromJson(data);
    }).toList();

    return users;
  }

  Future<AppUser?> getCurrentAppUserData() async {
    final firebaseUser = _authRepository.currentUser;

    if (firebaseUser == null) return null; // nicht eingeloggt

    final rohDaten = await _coreService.getDocument(
      path: 'users',
      docId: firebaseUser.uid,
    );

    final userDaten = rohDaten.data();
    if (userDaten == null) return null; // Daten nicht gefunden
    return AppUser.fromJson(userDaten);
  }
}
