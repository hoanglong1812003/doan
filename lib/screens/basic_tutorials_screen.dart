// screens/basic_tutorials_screen.dart
import 'package:flutter/material.dart';

class BasicTutorialsScreen extends StatelessWidget {
  final List<Map<String, String>> tutorials = [
    {'title': 'Cách trộn nguyên liệu', 'content': 'Trộn nhẹ các nguyên liệu.'},
    {'title': 'How to Shake Properly', 'content': 'Lắc với đá trong 15 giây.'},
    {'title': 'Cách đo lường', 'content': 'Sử dụng các công cụ đo lường thích hợp.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hướng dẫn cơ bản'),
      ),
      body: ListView.builder(
        itemCount: tutorials.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(tutorials[index]['title']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(tutorials[index]['content']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
