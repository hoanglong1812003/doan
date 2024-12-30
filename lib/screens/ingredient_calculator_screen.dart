// screens/ingredient_calculator_screen.dart
import 'package:flutter/material.dart';

class IngredientCalculatorScreen extends StatefulWidget {
  @override
  _IngredientCalculatorScreenState createState() =>
      _IngredientCalculatorScreenState();
}

class _IngredientCalculatorScreenState extends State<IngredientCalculatorScreen> {
  final TextEditingController servingsController = TextEditingController();
  double ratio = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính toán gia vị'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: servingsController,
              decoration: InputDecoration(
                labelText: 'Số lượng khẩu phần',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  ratio = double.tryParse(value) ?? 1.0;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Nguyên liệu đã điều chỉnh:'),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Nguyên liệu 1'),
                    trailing: Text('${(ratio * 50).toStringAsFixed(1)} g'),
                  ),
                  ListTile(
                    title: Text('Nguyên liệu 2'),
                    trailing: Text('${(ratio * 30).toStringAsFixed(1)} ml'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
