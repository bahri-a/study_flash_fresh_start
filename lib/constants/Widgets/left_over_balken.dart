import 'package:flutter/material.dart';

class LeftOverCardsBalken extends StatelessWidget {
  String fach = "";
  int cardsLeft;
  Color farbe;
  IconData fortschrittsBalken = Icons.bar_chart_sharp;
  LeftOverCardsBalken({
    super.key,
    required this.fach,
    required this.cardsLeft,
    required this.farbe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 5,
            bottom: 5,
          ),
          child: Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 255, 255, 255),
              border: BoxBorder.all(color: Colors.black, width: 0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                spacing: 20,
                children: [
                  Icon(fortschrittsBalken, size: 40, color: farbe),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fach,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$cardsLeft cards left",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
