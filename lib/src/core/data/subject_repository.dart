import 'package:study_flash/src/core/core_service.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';

class SubjectRepository {
  final CoreService _coreService;

  SubjectRepository(this._coreService);

  Future<List<Subject>> getSubjects() async {
    final rohdaten = await _coreService.getCollection(
      path: 'users/dhF552aPp7Os9JhPBNQD/subjects',
    );
    final rohdatenDocs = rohdaten.docs;

    final subjects = rohdatenDocs.map((e) {
      final data = e.data();
      return Subject.fromJson(data);
    }).toList();

    print(subjects);
    return subjects;
  }
}
