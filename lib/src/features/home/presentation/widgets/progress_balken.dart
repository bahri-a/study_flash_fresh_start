import 'package:flutter/material.dart';

class ProgressBalken extends StatelessWidget {
  const ProgressBalken({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                  Icon(
                    Icons.bar_chart_sharp,
                    size: 40,
                    color: const Color.fromARGB(255, 24, 128, 212),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Mathe", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("7 cards left to study", style: TextStyle(fontSize: 12)),
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
