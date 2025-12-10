import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/constants/Widgets/drawer_menu.dart';
import 'package:study_flash/constants/Widgets/my_navigation_bar.dart';
import 'package:study_flash/providers/auth_provider.dart';

class ShellScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: DrawerMenu(), // Dein Drawer lebt jetzt hier
      // Das AppBar lebt jetzt hier
      appBar: AppBar(
        toolbarHeight: 75,
        // 2. Titel dynamisch setzen
        title: Text(
          _getTitleForIndex(navigationShell.currentIndex),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
            },
            icon: const Icon(Icons.login_outlined),
          ),
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
