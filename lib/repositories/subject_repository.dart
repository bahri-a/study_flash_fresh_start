import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_flash/repositories/auth_repository.dart';
import 'package:study_flash/services/core_service.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';

class SubjectRepository {
  final CoreService _coreService;
  final AuthRepository _authRepository;

  SubjectRepository(this._coreService, this._authRepository);

  Future<List<Subject>> getSubjects() async {
    final uid = _authRepository.currentUser?.uid;

    if (uid == null) return [];

    final rohdaten = await _coreService.getCollection(
      path: "users/$uid/subjects",
      //path: 'users/dhF552aPp7Os9JhPBNQD/subjects',
    );
    final rohdatenDocs = rohdaten.docs;

    final subjects = rohdatenDocs.map((e) {
      final data = e.data();
      return Subject.fromJson(data);
    }).toList();

    return subjects;
  }
}
