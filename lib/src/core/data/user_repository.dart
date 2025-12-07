import 'package:study_flash/src/core/core_service.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';

class UserRepository {
  final CoreService _coreService;

  UserRepository(this._coreService);

  Future<List<Subject>> getUsers() async {
    final rohdaten = await _coreService.getCollection(path: 'users');
    final rohdatenDocs = rohdaten.docs;

    final users = rohdatenDocs.map((e) {
      final data = e.data();
      return Subject.fromJson(data);
    }).toList();

    return users;
  }
}
