import 'package:flutter/material.dart';
import 'package:note_app/components/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Header
          DrawerHeader(
            child: Icon(
              Icons.note,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 25,
            ),
          ),

          // Note tile
          DrawerTile(
            title: 'Notes',
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/note_page',
                (context) => false,
              );
            },
          ),
          DrawerTile(
            title: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/settings_page',
                (context) => false,
              );
            },
          ),

          // Settings tile
        ],
      ),
    );
  }
}
