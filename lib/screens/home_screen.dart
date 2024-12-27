import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bartender Guide'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Recipes'),
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Create Recipe'),
            onTap: () {
              Navigator.pushNamed(context, '/create-recipe');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Basic Tutorials'),
            onTap: () {
              Navigator.pushNamed(context, '/basic-tutorials');
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Drink Suggestions'),
            onTap: () {
              Navigator.pushNamed(context, '/drink-suggestions');
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Ingredient Calculator'),
            onTap: () {
              Navigator.pushNamed(context, '/ingredient-calculator');
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share Recipe'),
            onTap: () {
              Navigator.pushNamed(context, '/share-recipe');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About & Support'),
            onTap: () {
              Navigator.pushNamed(context, '/about-support');
            },
          ),
        ],
      ),
    );
  }
}
