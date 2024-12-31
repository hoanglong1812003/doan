import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'category_drinks_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> categories = [];
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryDescriptionController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // Lấy danh sách thể loại từ Firebase Realtime Database
  Future<void> _fetchCategories() async {
    try {
      DatabaseEvent event = await _database.child('categories').once();
      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;

      if (data != null) {
        setState(() {
          categories = data.entries.map((entry) {
            Map<String, dynamic> categoryData =
            Map<String, dynamic>.from(entry.value);
            return {
              'id': entry.key, // ID của thể loại
              'name': categoryData['name'] ?? 'No Name',
              'description': categoryData['description'] ?? 'No Description',
            };
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Thêm thể loại mới vào Firebase
  Future<void> _addCategory() async {
    String name = _categoryNameController.text.trim();
    String description = _categoryDescriptionController.text.trim();

    if (name.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin!')),
      );
      return;
    }

    try {
      await _database.child('categories').push().set({
        'name': name,
        'description': description,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thể loại đã được thêm thành công!')),
      );

      _categoryNameController.clear();
      _categoryDescriptionController.clear();
      _fetchCategories(); // Tải lại danh sách thể loại
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  // Xóa thể loại
  Future<void> _deleteCategory(String categoryId) async {
    try {
      await _database.child('categories/$categoryId').remove();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thể loại đã được xóa!')),
      );
      _fetchCategories(); // Tải lại danh sách thể loại
    } catch (e) {
      print('Error deleting category: $e');
    }
  }

  // Hiển thị danh sách đồ uống thuộc thể loại
  void _showCategoryDrinks(String categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDrinksScreen(categoryId: categoryId),
      ),
    );
  }

  // Hiển thị hộp thoại thêm thể loại
  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm thể loại mới'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Tên thể loại',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _categoryDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                _addCategory();
                Navigator.pop(context);
              },
              child: Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thể loại'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
      body: categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]['name']),
            subtitle: Text(categories[index]['description']),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteCategory(categories[index]['id']);
              },
            ),
            onTap: () {
              _showCategoryDrinks(categories[index]['id']);
            },
          );
        },
      ),
    );
  }
}