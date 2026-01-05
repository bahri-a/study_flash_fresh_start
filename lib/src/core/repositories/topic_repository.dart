import 'package:study_flash/src/core/models/topic/topic.dart';
import 'package:study_flash/src/core/repositories/auth_repository.dart';
import 'package:study_flash/src/core/services/core_service.dart';

class TopicRepository {
  final CoreService _coreService;
  final AuthRepository _authRepository;
  final String subjectId;

  TopicRepository(this._coreService, this._authRepository, this.subjectId);

  Future<List> getTopics() async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) return [];

    final rohdaten = await _coreService.getCollection(
      path: "users/$uid/Subjects/$subjectId/Topic",
    );

    final rohdatenDocs = rohdaten.docs;
    final topics = rohdatenDocs.map((e) {
      final data = e.data();
      return Topic.fromJson(data);
    }).toList();
    return topics;
  }
}
