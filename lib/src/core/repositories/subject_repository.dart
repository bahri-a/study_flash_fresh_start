import 'package:study_flash/src/core/repositories/auth_repository.dart';
import 'package:study_flash/src/core/services/core_service.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectRepository {
  final CoreService _coreService;
  final AuthRepository _authRepository;

  SubjectRepository(this._coreService, this._authRepository);

  Future<Subject?> getCurrentSubject({required String subjectId}) async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) return null;

    final rohdaten = FirebaseFirestore.instance.doc("users/$uid/subjects/$subjectId");
    final rohdatenDoc = await rohdaten.get();
    if (!rohdatenDoc.exists) return null;

    final currentSubject = rohdatenDoc.data();
    if (currentSubject == null) return null;
    currentSubject['id'] = rohdatenDoc.id;

    return Subject.fromJson(currentSubject);
  }

  // __________________________

  Future<List<Subject>> getSubjects() async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) return [];
    final rohdaten = await _coreService.getCollection(path: "users/$uid/subjects");
    final rohdatenDocs = rohdaten.docs;
    final subjects = rohdatenDocs.map((e) {
      final data = e.data();
      data['id'] = e.id;
      return Subject.fromJson(data);
    }).toList();
    return subjects;
  }

  // __________________________

  Future<void> addSubject({required String subjectName}) async {
    final uid = _authRepository.currentUser?.uid;
    final generatedId = FirebaseFirestore.instance.collection('users').doc().id;
    if (uid == null) throw Exception("Account nicht gefunden");

    final newSubject = Subject(
      id: generatedId,
      subjectName: subjectName,
      createdAt: DateTime.now(),
    );
    await _coreService.setDocument(
      docId: generatedId,
      path: 'users/$uid/subjects',
      data: newSubject.toJson(),
    );
  }

  //________________

}
