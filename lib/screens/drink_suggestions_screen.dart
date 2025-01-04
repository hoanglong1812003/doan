// screens/drink_suggestions_screen.dart
import 'package:flutter/material.dart';

class DrinkSuggestionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> drinks = [
    {
      'name': 'Mojito',
      'thành phần': ['Bạc hà', 'Chanh xanh', 'Rượu rum']
    },
    {
      'name': 'Espresso Martini',
      'thành phần': ['Espresso', 'Vodka']
    },
    {
      'name': 'Green Tea Smoothie',
      'thành phần': ['Trà xanh', 'Honey', 'Milk']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gợi ý đồ uống'),
      ),
      body: ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(drinks[index]['name']),
            subtitle:
                Text('Ingredients: ${drinks[index]['ingredients'].join(', ')}'),
            onTap: () {
              Navigator.pushNamed(context, '/recipe-details',
                  arguments: drinks[index]['name']);
            },
          );
        },
      ),
    );
  }
}
