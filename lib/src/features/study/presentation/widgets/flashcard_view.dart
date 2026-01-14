import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FlashcardView extends StatelessWidget {
  final String subjectId;
  final String topicId;

  const FlashcardView({super.key, required this.subjectId, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlipCard(
          front: Stack(
            children: [
              Container(
                height: 250,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.brown.shade200,
                  border: BoxBorder.all(width: 8, color: Colors.white),
                ),
                child: Center(
                  child: Text(topicId, style: TextStyle(color: Colors.white, fontSize: 45)),
                ),
              ),

              Positioned(
                bottom: 20,
                right: 20,
                child: Icon(CupertinoIcons.arrow_2_circlepath, size: 30, color: Colors.white),
              ),
            ],
          ),
          back: Stack(
            children: [
              Container(
                height: 250,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.brown.shade200,
                  border: BoxBorder.all(width: 8, color: Colors.white),
                ),
                child: Center(
                  child: Text(topicId, style: TextStyle(color: Colors.white, fontSize: 45)),
                ),
              ),

              Positioned(
                bottom: 20,
                right: 20,
                child: Icon(CupertinoIcons.arrow_2_circlepath, size: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
