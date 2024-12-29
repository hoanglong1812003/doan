// screens/favorites_screen.dart
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> favoriteRecipes = [
    'Mojito',
    'Espresso Martini',
    'Green Tea Latte',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mục yêu thích'),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteRecipes[index]),
            onTap: () {
              Navigator.pushNamed(context, '/recipe-details',
                  arguments: favoriteRecipes[index]);
            },
          );
        },
      ),
    );
  }
}
