// screens/share_recipe_screen.dart
import 'package:flutter/material.dart';

class ShareRecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chia sẽ công thức'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Logic to share the recipe
            // Example: Share via social media or QR code
          },
          child: Text('Chia sẽ công thức'),
        ),
      ),
    );
  }
}
