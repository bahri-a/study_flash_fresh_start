import 'package:study_flash/src/core/repositories/auth_repository.dart';
import 'package:study_flash/src/core/services/core_service.dart';
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
    );
    final rohdatenDocs = rohdaten.docs;
    final subjects = rohdatenDocs.map((e) {
      final data = e.data();
      return Subject.fromJson(data);
    }).toList();
    return subjects;
  }

  Future<void> addSubject({required String subjectName}) async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) throw Exception("Account nicht gefunden");
    final newSubject = Subject(
      subjectName: subjectName,
      createdAt: DateTime.now(),
    );
    _coreService.addDocument(
      path: 'users/$uid/subjects',
      data: newSubject.toJson(),
    );
  }
}
