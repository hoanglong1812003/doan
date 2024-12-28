import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Main application file
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/recipe_details_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/create_recipe_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/basic_tutorials_screen.dart';
import 'screens/drink_suggestions_screen.dart';
import 'screens/ingredient_calculator_screen.dart';
import 'screens/share_recipe_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_support_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BartenderApp());
}

class BartenderApp extends StatefulWidget {
  @override
  _BartenderAppState createState() => _BartenderAppState();
}

class _BartenderAppState extends State<BartenderApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bartender Guide',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/recipe-details': (context) => RecipeDetailsScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/create-recipe': (context) => CreateRecipeScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/basic-tutorials': (context) => BasicTutorialsScreen(),
        '/drink-suggestions': (context) => DrinkSuggestionsScreen(),
        '/ingredient-calculator': (context) => IngredientCalculatorScreen(),
        '/share-recipe': (context) => ShareRecipeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/about-support': (context) => AboutSupportScreen(),
      },
    );
  }
}
