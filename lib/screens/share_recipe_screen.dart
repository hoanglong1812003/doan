// screens/share_recipe_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShareRecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shareRecipe'.tr()),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Logic to share the recipe
            // Example: Share via social media or QR code
          },
          child: Text('shareRecipe'.tr()),
        ),
      ),
    );
  }
}
