// screens/search_screen.dart
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter recipe name or ingredient',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                // Implement search functionality here
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with the length of search results
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Recipe $index'),
                    subtitle: Text('Subtitle for Recipe $index'),
                    onTap: () {
                      Navigator.pushNamed(context, '/recipe-details', arguments: 'Recipe $index');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
