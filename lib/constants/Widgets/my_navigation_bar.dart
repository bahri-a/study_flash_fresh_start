import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.ac_unit_rounded),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.edit_document),
          label: "Cards",
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_sharp),
          label: "Charts",
        ),
      ],
      selectedIndex: currentIndex,

      indicatorColor: const Color.fromARGB(125, 93, 174, 240),
      onDestinationSelected: onDestinationSelected,
    );
  }
}
