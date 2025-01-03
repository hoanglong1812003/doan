import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cocktailGuide'.tr()),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.search),
            title: Text('search'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('categories'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('favorites'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('createRecipe'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/create-recipe');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('basicTutorials'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/basic-tutorials');
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('drinkSuggestions'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/drink-suggestions');
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('ingredientCalculator'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/ingredient-calculator');
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('shareRecipe'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/share-recipe');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('settings'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('aboutSupport'.tr()),
            onTap: () {
              Navigator.pushNamed(context, '/about-support');
            },
          ),
        ],
      ),
    );
  }
}
