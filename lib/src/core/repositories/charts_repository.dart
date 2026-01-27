import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';

class ChartsRepository {
  final String userId;

  ChartsRepository({required this.userId});

  Future<List<Flashcard>> getAllFlashcards() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collectionGroup('flashcards').get();

      // Das Ergebnis mappen
      final allCards = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Flashcard.fromJson(data);
      }).toList();

      // OPTIONAL: Client-seitiges Filtern (siehe Warnung unten)
      // return allCards;

      // Da CollectionGroup über die GANZE Datenbank sucht, könnten hier auch
      // Karten von anderen Nutzern dabei sein, wenn du keine Security Rules hast.
      // Wenn dein Pfad users/uid/... ist, kannst du hier prüfen, ob der Pfad
      // die userId enthält:
      return allCards.where((card) {
        // Check ist schwierig ohne Pfad-Referenz im Model.
        // Besser: Der Pfad des Dokuments (doc.reference.path) enthält die User-ID.
        return doc.reference.path.contains(userId);
      }).toList();
    } catch (e) {
      print("Fehler beim Laden aller Karten: $e");
      return [];
    }
  }
}
