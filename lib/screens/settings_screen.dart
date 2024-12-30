// screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Thay đổi ngôn ngữ'),
            onTap: () {
              // Navigate to language selection screen or open dialog
            },
          ),
          ListTile(
            title: Text('Thay đổi giao diện'),
            onTap: () {
              // Logic to toggle between light and dark mode
            },
          ),
          ListTile(
            title: Text('Chuyển đổi đơn vị'),
            onTap: () {
              // Logic to change measurement units
            },
          ),
        ],
      ),
    );
  }
}
