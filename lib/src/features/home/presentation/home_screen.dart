import 'package:flutter/material.dart';
import 'package:study_flash/src/core/core_service.dart';
import 'package:study_flash/src/core/data/subject_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SubjectRepository repository;

  @override
  void initState() {
    super.initState();
    repository = SubjectRepository(CoreService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: repository.getSubjects(),
        builder: (context, snapshot) {
          // 1. Ladezustand: Zeige Spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Fehlerzustand: Zeige Fehlermeldung
          // WICHTIG: Das fängt Datenbank- oder Parsing-Fehler ab
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ein Fehler ist aufgetreten: ${snapshot.error}",
              ),
            );
          }

          // 3. Erfolgsfall mit Daten
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final subjects = snapshot.data!;
            return ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index].email),
                  subtitle: Text(subjects[index].username),
                );
              },
            );
          }

          // 4. Fallback: Fertig, aber keine Daten (Leere Liste)
          return const Center(child: Text("Keine Fächer gefunden."));
        },
      ),
    );
  }
}
