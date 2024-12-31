import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateRecipeScreen extends StatefulWidget {
  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  String? selectedCategoryId; // ID của thể loại được chọn
  List<Map<String, dynamic>> categories = []; // Danh sách thể loại

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // Lấy danh sách thể loại từ Firestore
  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('categories').get();
      List<Map<String, dynamic>> fetchedCategories = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'] ?? 'No Name',
        };
      }).toList();

      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Lưu công thức vào Firestore
  Future<void> saveRecipe() async {
    String name = nameController.text.trim();
    String ingredients = ingredientsController.text.trim();
    String instructions = instructionsController.text.trim();

    if (name.isEmpty || ingredients.isEmpty || instructions.isEmpty || selectedCategoryId == null) {
      // Hiển thị cảnh báo nếu có trường bị bỏ trống
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin!')),
      );
      return;
    }

    try {
      // Lưu dữ liệu vào Firestore
      await FirebaseFirestore.instance.collection('recipes').add({
        'name': name,
        'ingredients': ingredients.split(',').map((e) => e.trim()).toList(),
        'instructions': instructions,
        'categoryId': selectedCategoryId, // Thể loại liên quan
        'created_at': FieldValue.serverTimestamp(),
      });

      // Hiển thị thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Công thức đã được lưu thành công!')),
      );

      // Xóa dữ liệu trong các trường nhập liệu
      nameController.clear();
      ingredientsController.clear();
      instructionsController.clear();
      setState(() {
        selectedCategoryId = null;
      });
    } catch (e) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo công thức mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                decoration: InputDecoration(
                  labelText: 'Thể loại',
                  border: OutlineInputBorder(),
                ),
                items: categories
                    .map((category) => DropdownMenuItem<String>(
                  value: category['id'],
                  child: Text(category['name']),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategoryId = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Thành phần',
                  hintText: 'Nhập các thành phần, cách nhau bởi dấu phẩy',
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
                onPressed: saveRecipe,
                child: Text('Lưu công thức'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
