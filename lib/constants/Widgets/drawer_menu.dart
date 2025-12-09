import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
          Text("Logout", style: TextStyle(fontSize: 20)),
          Text("Settings", style: TextStyle(fontSize: 20)),
          Text("Contact", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
