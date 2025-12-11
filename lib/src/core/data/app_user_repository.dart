import 'package:study_flash/providers/auth_provider.dart';
import 'package:study_flash/services/core_service.dart';
import 'package:study_flash/src/core/models/app_user/app_user.dart';
import 'package:study_flash/services/auth_repository.dart';

class UserRepository {
  final CoreService _coreService;
  final AuthRepository authRepository;

  UserRepository(this._coreService, this.authRepository);

  Future<List<AppUser>> getUsers() async {
    final rohdaten = await _coreService.getCollection(path: 'users');
    final rohdatenDocs = rohdaten.docs;

    final users = rohdatenDocs.map((e) {
      final data = e.data();
      return AppUser.fromJson(data);
    }).toList();

    return users;
  }

  Future<AppUser> getCurrentUserData() async {
    final firebaseUser = authRepository.currentUser;
    if (firebaseUser == null) {
      throw Exception("Kein User eingeloggt");
    }
    final rohDaten = await _coreService.getDocument(
      path: 'users',
      docId: firebaseUser.uid,
    );

    final userDaten = rohDaten.data();
    if (userDaten == null) {
      throw Exception("User Daten nicht gefunden");
    }
    return AppUser.fromJson(userDaten);
  }
}
