// screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Language'),
            onTap: () {
              // Navigate to language selection screen or open dialog
            },
          ),
          ListTile(
            title: Text('Switch Theme'),
            onTap: () {
              // Logic to toggle between light and dark mode
            },
          ),
          ListTile(
            title: Text('Change Units'),
            onTap: () {
              // Logic to change measurement units
            },
          ),
        ],
      ),
    );
  }
}
