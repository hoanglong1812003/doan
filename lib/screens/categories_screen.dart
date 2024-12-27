// screens/categories_screen.dart
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final List<String> categories = [
    'Cocktails',
    'Mocktails',
    'Cà phê',
    'Trà',
    'Sinh tố',
    'Khác'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thể loại'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              // Pass selected category to a filtered list screen if needed
            },
          );
        },
      ),
    );
  }
}
