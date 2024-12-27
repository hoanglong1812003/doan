// screens/recipe_details_screen.dart
import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String recipeName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Recipe';

    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipeName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('- Ingredient 1\n- Ingredient 2\n- Ingredient 3'),
            SizedBox(height: 20),
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
                '1. Step one\n2. Step two\n3. Step three\n\nEnjoy your drink!'),
          ],
        ),
      ),
    );
  }
}
