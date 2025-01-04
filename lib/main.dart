import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  await EasyLocalization.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedTheme = prefs.getString('theme');
  ThemeMode initialThemeMode = savedTheme == ThemeMode.dark.toString()
      ? ThemeMode.dark
      : ThemeMode.light;

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: Locale('vi'),
      child: MyApp(initialThemeMode),
    ),
  );
}

class MyApp extends StatefulWidget {
  final ThemeMode initialThemeMode;

  MyApp(this.initialThemeMode);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  // Hàm lưu lại theme vào SharedPreferences
  void _saveTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeMode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bartender Guide',
      theme: ThemeData.light(), // Chủ đề sáng
      darkTheme: ThemeData.dark(), // Chủ đề tối
      themeMode: _themeMode, // Áp dụng chế độ sáng/tối
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
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
        '/settings': (context) => SettingsScreen(
          themeMode: _themeMode,
          onThemeChanged: (newTheme) {
            setState(() {
              _themeMode = newTheme;
            });
            _saveTheme(newTheme); // Lưu theme khi thay đổi
          },
        ),
        '/about-support': (context) => AboutSupportScreen(),
      },
    );
  }
}
