import 'package:flutter/material.dart';

class IconsForFlashcard extends StatelessWidget {
  const IconsForFlashcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Icon(Icons.thumb_down, color: Colors.red, size: 60),
          Icon(Icons.thumb_up, color: Colors.green, size: 60),
        ],
      ),
    );
  }
}
