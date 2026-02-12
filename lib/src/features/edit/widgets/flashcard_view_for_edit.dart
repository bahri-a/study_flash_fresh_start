import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_flash/src/core/models/flashcard/flashcard.dart';

class FlashcardViewForEditScreen extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardViewForEditScreen({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.4),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: 250,
          width: 350,
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            front: _buildCardSide(flashcard.front, const Color.fromRGBO(33, 150, 243, 1)),
            back: _buildCardSide(flashcard.back, const Color.fromRGBO(33, 110, 203, 1)),
          ),
        ),
      ),
    );
  }
}

Widget _buildCardSide(String text, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(width: 4, color: Colors.white),
    ),
    child: Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 20,
          right: 20,
          child: Icon(CupertinoIcons.arrow_2_circlepath, size: 30, color: Colors.white),
        ),
      ],
    ),
  );
}
