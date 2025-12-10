import 'package:study_flash/services/core_service.dart';
import 'package:study_flash/src/core/models/user/user.dart';

class UserRepository {
  final CoreService _coreService;

  UserRepository(this._coreService);

  Future<List<User>> getUsers() async {
    final rohdaten = await _coreService.getCollection(path: 'users');
    final rohdatenDocs = rohdaten.docs;

    final users = rohdatenDocs.map((e) {
      final data = e.data();
      return User.fromJson(data);
    }).toList();

    return users;
  }
}
