import 'package:study_flash/src/core/core_service.dart';
import 'package:study_flash/src/core/models/subject/subject.dart';

class SubjectRepository {
  final CoreService _coreService;

  SubjectRepository(this._coreService);

  Future<List<Subject>> getSubjects() async {
    final rohdaten = await _coreService.getCollection(path: 'users');

    print("Dokumentenanzahl: ${rohdaten.docs.length}");

    final finalSubjects = rohdaten.docs.map((e) {
      final data = e.data();
      print("Daten aus Firebase: $data");
      return Subject.fromJson(data);
    }).toList();

    return finalSubjects;
  }
}
