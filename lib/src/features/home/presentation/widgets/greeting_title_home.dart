import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GreetingTitleHome extends StatelessWidget {
  final String name;

  const GreetingTitleHome({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(
      context,
    ).uri.toString();

    String title;

    if (currentPath == '/') {
      title = "Here's your dashboard";
    } else if (currentPath == '/Cardsscreen') {
      title = "Here are your cards";
    } else {
      title = "Here are you charts";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, $name",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ), //!     Begrüßung
        Text(title),
      ],
    );
  }
}
