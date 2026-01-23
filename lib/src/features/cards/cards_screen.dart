import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/src/core/providers/flashcard_provider.dart';
import 'package:study_flash/src/core/providers/subject_provider.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsData = ref.watch(subjectsListProvider);
    final subjectsProvider = ref.watch(subjectRepositoryProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Meine Cards",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Suche nach Karten...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: subjectsData.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(child: Text("Keine Cards vorhanden"));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),

                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return _buildCardItem(
                            title: "progress XY",
                            subject: data[index].subjectName,
                            color: Colors.grey,
                            cardsTopics: () {
                              // Rüber zu CardsTopics
                              context.push(
                                "/cardstopics/${data[index].id}/${data[index].subjectName}",
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                },
                error: (error, stackTrace) {
                  return Center(child: Text("Fehler beim Laden: $error"));
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem({
    required String title,
    required String subject,
    required Color color,
    required VoidCallback cardsTopics,
  }) {
    return InkWell(
      onTap: () {
        cardsTopics();
      },
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(149, 219, 191, 114),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 25),
          child: Text(
            subject,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
