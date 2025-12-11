import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
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
    try {
      final result = await _authRepository.createAccount(
        email: email,
        password: password,
        username: username,
      );
      final uid = result.user?.uid;
      if (uid == null)
        throw Exception("UserID konnte nicht erstellt werden");
      await _coreService.setDocument(
        path: "users",
        docId: uid,
        data: {
          'email': email,
          'username': username,
          'createdAt': FieldValue.serverTimestamp(),
        },
      );
      await _authRepository.updateDisplayName(username: username);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception("Ein unerwarteter Fehler ist aufgetreten: $e");
    }
  }

  Stream<AppUser?> streamCurrentAppUserData() {
    return _authRepository.authStateChanges.switchMap((firebaseUser) {
      if (firebaseUser == null) {
        return Stream.value(null);
      }
      return _coreService
          .streamDocument(path: 'users', docId: firebaseUser.uid)
          .map((e) {
            final data = e.data();
            if (data == null) return null;
            return AppUser.fromJson(data);
          });
    });
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

  //! Wird wahrscheinlich nicht gebraucht
  // Future<List<AppUser>> getAppUsers() async {
  //   final rohdaten = await _coreService.getCollection(path: 'users');
  //   final rohdatenDocs = rohdaten.docs;

  //   final users = rohdatenDocs.map((e) {
  //     final data = e.data();
  //     return AppUser.fromJson(data);
  //   }).toList();

  //   return users;
  // }
}
