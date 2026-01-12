import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_flash/src/core/models/topic/topic.dart';
import 'package:study_flash/src/core/repositories/auth_repository.dart';
import 'package:study_flash/src/core/services/core_service.dart';

class TopicRepository {
  final CoreService _coreService;
  final AuthRepository _authRepository;
  final String subjectId;

  TopicRepository(this._coreService, this._authRepository, this.subjectId);

  Future<List<Topic>> getTopics() async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) return [];

    final rohdaten = await _coreService.getCollection(
      path: "users/$uid/subjects/$subjectId/topics",
    );

    final rohdatenDocs = rohdaten.docs;
    final topics = rohdatenDocs.map((e) {
      final data = e.data();
      data['id'] = e.id;
      return Topic.fromJson(data);
    }).toList();
    return topics;
  }

  //
  // _______________________
  //

  Future<void> addTopic({required String topicName}) async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) throw Exception("User nicht eingeloggt");

    final generatedId = FirebaseFirestore.instance.collection("topics").doc().id;
    final newTopic = Topic(topicName: topicName, id: generatedId, createdAt: DateTime.now());
    await _coreService.setDocument(
      path: "users/$uid/subjects/$subjectId/topics",
      docId: generatedId,
      data: newTopic.toJson(),
    );
  }

  //
  ///_____________________
  //

  Future<void> deleteTopic(String topicId) async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) throw Exception("User nicht eingeloggt");

    await _coreService.deleteDocument(
      path: "users/$uid/subjects/$subjectId/topics",
      docId: topicId,
    );
  }
}
