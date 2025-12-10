import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/auth_provider.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      width: 225,
      child: Column(
        spacing: 35,
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(top: 40),
            child: Text(
              "Menu",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ref.read(authRepositoryProvider).signOut();
            },
            child: Text("Logout", style: TextStyle(fontSize: 20)),
          ),
          Text("Settings", style: TextStyle(fontSize: 20)),
          Text("Contact", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
