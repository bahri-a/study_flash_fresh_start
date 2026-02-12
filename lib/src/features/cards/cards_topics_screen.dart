import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/providers/topic_provider.dart';
import 'package:go_router/go_router.dart';

//todo: Mach, dass Topics in buildCardItem angezeigt werden statt Subjects
class CardsTopics extends ConsumerWidget {
  final String subjectId;
  final String subjectName;
  const CardsTopics({super.key, required this.subjectId, required this.subjectName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicsProvider = ref.watch(topicsListProvider(subjectId));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Topics von $subjectName",
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
              child: topicsProvider.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(child: Text("Keine Topics vorhanden"));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return _buildCardItem(
                            title: "9 cards",
                            topicName: data[index].topicName,
                            topicId: data[index].id,
                            context: context,
                            onDelete: () {},
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
    required String topicName,
    required String topicId,
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    return InkWell(
      onTap: () {
        context.push("/editcards/$subjectId/$topicId");
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(33, 150, 243, 1),
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
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topicName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_horiz, color: Color.fromARGB(255, 255, 255, 255)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      onSelected: (value) {
                        if (value == "delete") {
                          onDelete();
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            // Wichtig: Der Wert, der an onSelected gesendet wird
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline, color: Colors.red),
                                SizedBox(width: 10),
                                Text("Löschen", style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
