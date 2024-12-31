import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoryDrinksScreen extends StatefulWidget {
  final String categoryId;

  CategoryDrinksScreen({required this.categoryId});

  @override
  _CategoryDrinksScreenState createState() => _CategoryDrinksScreenState();
}

class _CategoryDrinksScreenState extends State<CategoryDrinksScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> drinks = [];

  @override
  void initState() {
    super.initState();
    _fetchDrinks();
  }

  Future<void> _fetchDrinks() async {
    try {
      DatabaseEvent event = await _database
          .child('drinks')
          .orderByChild('categoryId')
          .equalTo(widget.categoryId)
          .once();

      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          drinks = data.entries.map((entry) {
            return Map<String, dynamic>.from(entry.value);
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching drinks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đồ uống trong thể loại'),
      ),
      body: drinks.isEmpty
          ? Center(child: Text('Không có đồ uống nào!'))
          : ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(drinks[index]['name'] ?? 'No Name'),
          );
        },
      ),
    );
  }
}
