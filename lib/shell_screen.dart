import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/constants/Widgets/drawer_menu.dart';
import 'package:study_flash/constants/Widgets/my_navigation_bar.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({
    super.key,
    required this.navigationShell, // 1. Der "Inhalt" von GoRouter
  });

  final StatefulNavigationShell navigationShell;

  // Hilfsfunktion, um den Titel basierend auf dem Tab zu setzen
  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Cards";
      case 2:
        return "Charts";
      default:
        return "Home";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(), // Dein Drawer lebt jetzt hier
      // Das AppBar lebt jetzt hier
      appBar: AppBar(
        toolbarHeight: 50,
        // 2. Titel dynamisch setzen
        title: Text(
          _getTitleForIndex(navigationShell.currentIndex),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        actions: [
          // Dein Dark-Mode-Button lebt jetzt hier
          // Padding(
          //   padding: const EdgeInsets.only(right: 20),
          //   child: IconButton(
          //     onPressed: () {
          //       isDarkModeNotifier.value = !isDarkModeNotifier.value;
          //     },
          //     icon: ValueListenableBuilder(
          //       valueListenable: isDarkModeNotifier,
          //       builder: (context, isDarkMode, child) {
          //         return Icon(
          //           isDarkMode
          //               ? Icons.light_mode_outlined
          //               : Icons.dark_mode_outlined,
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),

      // 3. Der Body ist die 'navigationShell'
      // Sie zeigt automatisch den richtigen Screen (Home, Cards, Charts)
      body: navigationShell,

      // 4. Die vereinfachte NavigationBar wird hier verwendet
      bottomNavigationBar: MyNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          // 5. 'goBranch' verwenden, NICHT 'context.go'
          // Dies wechselt den Tab, ohne den State zu verlieren
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
