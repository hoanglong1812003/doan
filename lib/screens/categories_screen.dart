import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // Hàm để lấy dữ liệu từ Firebase Realtime Database
  Future<void> _fetchCategories() async {
    try {
      // Lấy dữ liệu từ node "categories"
      DatabaseEvent event = await _database.child('categories').once();
      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;

      if (data != null) {
        setState(() {
          categories = data.entries.map((entry) {
            Map<String, dynamic> categoryData =
                Map<String, dynamic>.from(entry.value);
            return {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thể loại'),
      ),
      body: categories.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Hiển thị khi đang tải dữ liệu
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index]['name']!),
                  subtitle: Text(categories[index]['description']!),
                  onTap: () {
                    // Logic xử lý khi người dùng chọn một thể loại
                    // Ví dụ: chuyển đến màn hình hiển thị các công thức theo thể loại
                  },
                );
              },
            ),
    );
  }
}
