import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/providers/flashcard_provider.dart';

class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  // Farben
  final Color primaryBlue = const Color(0xFF2196F3);
  final Color accentBeige = const Color(0xFFE6D8B6);
  final Color backgroundGrey = const Color(0xFFFAFAFA);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(),

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
  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: accentBeige, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //todo:
            //! Alle Karte, die ein rating von 1-3 haben unter "Gesamt Kurzzeitgedächtnis" zusammenaddieren. Und alle ratings 4 aufwärts in "Langzeitgedächnis" zusammenfassen
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Gesamt gelernt", style: TextStyle(color: Colors.black54, fontSize: 14)),
              const SizedBox(height: 5),
              const Text(
                "1.240 Karten",
                style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
            child: const Icon(Icons.bar_chart, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Einfaches Balkendiagramm Widget
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

  // Ein einzelner Balken für das Diagramm
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

  // Zeile für Fach-Fortschritt
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
