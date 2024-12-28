// screens/create_recipe_screen.dart
import 'package:flutter/material.dart';

class CreateRecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ingredientsController = TextEditingController();
    final TextEditingController instructionsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo công thức mớ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Tên công thức',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(
                labelText: 'Thành phần',
                hintText: 'Enter ingredients separated by commas',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 10),
            TextField(
              controller: instructionsController,
              decoration: InputDecoration(
                labelText: 'Hướng dẫn',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to save the recipe
              },
              child: Text('Lưu công thức'),
            ),
          ],
        ),
      ),
    );
  }
}
