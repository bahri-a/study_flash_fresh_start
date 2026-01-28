import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';

class ChartsRepository {
  final String userId;

  ChartsRepository({required this.userId});

  Future<List<Flashcard>> getAllFlashcardsOfUser() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('flashcards')
          .where('userId', isEqualTo: userId)
          .get();

      // Das Ergebnis mappen bzw. iterieren
      final allCards = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Flashcard.fromJson(data);
      }).toList();

      return allCards;
    } catch (e) {
      print("Fehler: $e");
      return [];
    }
  }
}
