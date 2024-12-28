import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RecipeDetailsScreen extends StatefulWidget {
  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Map<String, dynamic>? recipeDetails;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final String? recipeId =
        ModalRoute.of(context)?.settings.arguments as String?;

    if (recipeId != null) {
      _fetchRecipeDetails(recipeId);
    }
  }

  Future<void> _fetchRecipeDetails(String recipeId) async {
    try {
      DatabaseEvent event = await _database.child('recipes/$recipeId').once();
      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;

      if (data != null) {
        setState(() {
          recipeDetails = {
            'name': data['name'] ?? 'No Name',
            'ingredients': data['ingredients'] ?? 'No Ingredients',
            'instructions': data['instructions'] ?? 'No Instructions',
            'image_path': data['image_path'] ?? '',
          };
        });
      }
    } catch (e) {
      print('Error fetching recipe details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recipeDetails == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Split the ingredients string into a list based on commas (assuming ingredients are separated by commas in your data)
    List<String> ingredientsList =
        (recipeDetails!['ingredients'] as String).split(',').map((ingredient) {
      return ingredient.trim(); // Remove any leading or trailing spaces
    }).toList();

    // Split the instructions string into a list based on newline characters (assuming instructions are separated by newline)
    List<String> instructionsList = (recipeDetails!['instructions'] as String)
        .split('\n')
        .map((instruction) {
      return instruction.trim(); // Remove any leading or trailing spaces
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(recipeDetails!['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị tên công thức
            Text(
              recipeDetails!['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Hiển thị thành phần
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            // Hiển thị mỗi thành phần với dấu -
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ingredientsList.map((ingredient) {
                return Text('- $ingredient');
              }).toList(),
            ),
            SizedBox(height: 20),
            // Hiển thị hướng dẫn
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            // Hiển thị mỗi bước với dấu -
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: instructionsList.map((instruction) {
                return Text('- $instruction');
              }).toList(),
            ),
            // Hiển thị ảnh công thức (nếu có)
            if (recipeDetails!['image_path']?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.network(recipeDetails!['image_path']),
              ),
          ],
        ),
      ),
    );
  }
}
