import 'package:cloud_firestore/cloud_firestore.dart';

//
//
//

class CoreService {
  // Zugriff auf die Firestore-Instanz
  // Damit greifen wir auf die Datenbank zu.
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- HILFSFUNKTIONEN FÜR REPOSITORIES ---

  // Holt alle Dokumente einer Collection bzw. eines Containers
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection({
    required String path,
  }) async {
    return _db.collection(path).get();
  }

  // Holt ein einzelnes Document von einem Container bzw. einer Collection
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String path,
    required String docId,
  }) async {
    return _db.collection(path).doc(docId).get();
  }

  // --- CRUD OPERATIONEN ---

  // CREATE: Fügt ein neues Dokument hinzu und lässt Firestore die ID generieren.
  Future<DocumentReference<Map<String, dynamic>>> addDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    return _db.collection(path).add(data);
  }

  // SET: Aktualisiert oder überschreibt ein existierendes Dokument mit bekannter ID.
  Future<void> setDocument({
    required String path,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    // set() überschreibt das gesamte Dokument oder erstellt es, falls es nicht existiert.
    await _db.collection(path).doc(docId).set(data);
  }

  // UPDATE: Aktualisiert nur einzelne Felder eines existierenden Dokuments.
  Future<void> updateDocument({
    required String path,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection(path).doc(docId).update(data);
  }

  // DELETE: Löscht ein Dokument.
  Future<void> deleteDocument({
    required String path,
    required String docId,
  }) async {
    await _db.collection(path).doc(docId).delete();
  }

  // --- STREAMING (Echtzeit-Updates) ---

  // Stellt einen Stream für eine gesamte Collection bereit.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required String path,
  }) {
    return _db.collection(path).snapshots();
  }

  // Stellt einen Stream für ein einzelnes Dokument bereit.
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDocument({
    required String path,
    required String docId,
  }) {
    return _db.collection(path).doc(docId).snapshots();
  }
}
