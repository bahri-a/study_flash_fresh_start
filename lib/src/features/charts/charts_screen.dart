import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';
import 'package:study_flash/src/core/providers/charts_provider.dart';

class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  // Farben
  final Color primaryBlue = const Color(0xFF2196F3);
  final Color myBlueColor = const Color.fromRGBO(33, 150, 243, 1);
  final Color backgroundGrey = const Color(0xFFFAFAFA);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCardsOfUser = ref.watch(allFlashcardsOfUser);
    final highRatedCount = ref.watch(highRatedCards);
    final lowRatedCount = ref.watch(lowRatedCards);
    final stats = ref.watch(statsPercentage);

    //! Später entfernen - TESTZWECK
    final allCards = ref.watch(allCountedCards);
    //! Später entfernen - TESTZWECk

    return Scaffold(
      backgroundColor: backgroundGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              allCards.when(
                data: (data) => Text("all Cards: $data"),
                error: (error, stackTrace) => Text("error"),
                loading: () => Text("lädt"),
              ),
              // LERNSTATUS
              _buildSummaryCard(
                allCardsAsync: allCardsOfUser,
                highRatedCountAsync: highRatedCount,
                lowRatedCountAsync: lowRatedCount,
                stats: stats,
              ),

              const SizedBox(height: 30),

              const Text(
                "Lernaktivität",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 15),

              // Balkendiagramm
              _buildActivityChart(),

              const SizedBox(height: 30),

              const Text(
                "Fortschritt pro Fach",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 15),

              // Progress pro Fach
              _buildSubjectProgress("Coding", 0.85, primaryBlue),
              _buildSubjectProgress("Mathe", 0.45, Colors.orangeAccent),
              _buildSubjectProgress("Türkisch", 0.70, Colors.redAccent),
              _buildSubjectProgress("Arabisch", 0.30, Colors.green),
              _buildSubjectProgress("Informatik", 0.95, Colors.purpleAccent),
            ],
          ),
        ),
      ),
    );
  }

  // Widget für gesamte Zusammenfassung
  Widget _buildSummaryCard({
    required AsyncValue<int> highRatedCountAsync,
    required AsyncValue<int> lowRatedCountAsync,
    required AsyncValue<List<Flashcard>> allCardsAsync,
    required AsyncValue<List<double>> stats,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
      decoration: BoxDecoration(color: myBlueColor, borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          const Text(
            "Lernstatus",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          CountRatedCards(
            asyncCountData: highRatedCountAsync,
            title: "Im Langzeitgedächtnis",
            stats: stats,
            isHigh: true,
          ),
          SizedBox(height: 20),
          CountRatedCards(
            asyncCountData: lowRatedCountAsync,
            title: "Im Kurzzeitgedächtnis",
            stats: stats,
            isHigh: false,
          ),
        ],
      ),
    );
  }

  // Balkendiagramm //! mit Daten füllen
  Widget _buildActivityChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, spreadRadius: 5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar("Mo", 0.3),
          _buildBar("Di", 0.5),
          _buildBar("Mi", 0.2),
          _buildBar("Do", 0.8, isSelected: true), // Aktueller Tag hervorgehoben
          _buildBar("Fr", 0.6),
          _buildBar("Sa", 0.4),
          _buildBar("So", 0.7),
        ],
      ),
    );
  }

  // Einzelner Balken  //! mit Daten füllen
  Widget _buildBar(String day, double percentage, {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          height: 150 * percentage, // Dynamische Höhe
          width: 12,
          decoration: BoxDecoration(
            color: isSelected ? primaryBlue : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            color: isSelected ? Colors.black87 : Colors.grey,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Zeile für Fach-Fortschritt //! mit Daten füllen
  Widget _buildSubjectProgress(String title, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey[100],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountRatedCards extends StatelessWidget {
  final AsyncValue<int> asyncCountData;
  final String title;
  final AsyncValue<List<double>> stats;
  final bool isHigh;

  const CountRatedCards({
    super.key,
    required this.asyncCountData,
    required this.title,
    required this.stats,
    required this.isHigh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // --- LINKER TEIL (Anzahl der Karten)
        asyncCountData.when(
          data: (count) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(height: 5),
                Text(
                  count != 1 ? "$count Karten" : "$count Karte",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => const Text("-"),
          loading: () => const SizedBox(
            height: 20,
            width: 100,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),

        // --- RECHTER TEIL (Prozentanzeige)
        Container(
          height: 55,
          width: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
          child: stats.when(
            data: (percentageList) {
              if (percentageList.length < 2) return const Text("-");
              final double rawValue = isHigh ? percentageList[0] : percentageList[1];

              final int percentValue = (rawValue * 100).toInt();

              return Text(
                "$percentValue%", // <--- HIER fügen wir das % Zeichen an
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              );
            },
            error: (error, stackTrace) => const Icon(Icons.error, size: 20),
            loading: () => const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ],
    );
  }
}
