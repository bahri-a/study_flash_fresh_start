import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';
import 'package:study_flash/src/core/repositories/auth_repository.dart';
import 'package:study_flash/src/core/services/core_service.dart';

class FlashcardRepository {
  final CoreService coreService;
  final AuthRepository authRepository;
  final String subjectId;
  final String topicId;

  FlashcardRepository({
    required this.authRepository,
    required this.coreService,
    required this.subjectId,
    required this.topicId,
  });

  Future<void> deleteFlashcard({required String flashcardId}) async {
    final uid = authRepository.currentUser?.uid;
    if (uid == null) return;
    final path = "users/$uid/subjects/$subjectId/topics/$topicId/flashcards";
    await coreService.deleteDocument(docId: flashcardId, path: path);
  }

  //
  //_________________________
  //

  // Add Flashcard
  Future<void> addFlashcard({required String front, required String back}) async {
    final uid = authRepository.currentUser?.uid;
    if (uid == null) return;

    final collectionPath = "users/$uid/subjects/$subjectId/topics/$topicId/flashcards";
    final generatedId = FirebaseFirestore.instance.collection('flashcards').doc().id;

    final newCard = Flashcard(id: generatedId, front: front, back: back, userId: uid);

    await coreService.setDocument(path: collectionPath, docId: generatedId, data: newCard.toJson());
  }

  //
  //_________________________
  //

  // Get Flashcards of topic
  Future<List<Flashcard>> getFlashcards() async {
    final uid = authRepository.currentUser?.uid;
    if (uid == null) return [];

    final collectionPath = "users/$uid/subjects/$subjectId/topics/$topicId/flashcards";

    final rohdaten = await coreService.getCollection(path: collectionPath);
    final rohdatenDocs = rohdaten.docs;

    final flashcards = rohdatenDocs.map((e) {
      final data = e.data();
      data['id'] = e.id;
      return Flashcard.fromJson(data);
    }).toList();

    flashcards.sort((a, b) => a.rating.compareTo(b.rating));

    return flashcards;
  }

  //
  //_________________________
  //

  Future<void> updateRating({required String flashcardId, required int newRating}) async {
    final uid = authRepository.currentUser?.uid;
    if (uid == null) return;

    await coreService.updateDocument(
      path: "users/$uid/subjects/$subjectId/topics/$topicId/flashcards",
      docId: flashcardId,
      data: {'rating': newRating},
    );
  }

  //
  //____________________________
  //

  Future<void> updateFlashcard({
    required String front,
    required String back,
    required String flashcardId,
  }) async {
    final uid = authRepository.currentUser?.uid;
    if (uid == null) return;

    final collectionPath = "users/$uid/subjects/$subjectId/topics/$topicId/flashcards";
    //final generatedId = FirebaseFirestore.instance.collection('flashcards').doc().id;

    final Map<String, dynamic> changes = {'front': front, 'back': back};

    await coreService.updateDocument(path: collectionPath, docId: flashcardId, data: changes);
  }
}
