import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> searchResults = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    _fetchAllRecipes(); // Fetch all recipes when the screen loads.
  }

  // Hàm lấy tất cả các công thức từ Firebase Realtime Database
  Future<void> _fetchAllRecipes() async {
    try {
      DatabaseEvent event = await _database.child('recipes').once();
      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;

      if (data != null) {
        List<Map<String, dynamic>> results = [];
        data.forEach((key, value) {
          String name = value['name'] ?? '';
          String ingredients = value['ingredients'] ?? '';

          results.add({
            'name': name,
            'ingredients': ingredients,
            'recipe_id': key,
          });
        });

        setState(() {
          searchResults = results;
        });
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }

  // Hàm tìm kiếm trong Firebase Realtime Database
  Future<void> _searchRecipes(String query) async {
    try {
      if (query.isEmpty) {
        // Nếu không có từ khóa tìm kiếm, hiển thị tất cả công thức
        _fetchAllRecipes();
        return;
      }

      // Lấy danh sách công thức từ Firebase
      DatabaseEvent event = await _database.child('recipes').once();
      Map<dynamic, dynamic>? data = event.snapshot.value as Map?;

      if (data != null) {
        List<Map<String, dynamic>> results = [];
        data.forEach((key, value) {
          String name = value['name'] ?? '';
          String ingredients = value['ingredients'] ?? '';

          // Kiểm tra xem tên công thức hoặc thành phần có chứa truy vấn hay không
          if (name.toLowerCase().contains(query.toLowerCase()) ||
              ingredients.toLowerCase().contains(query.toLowerCase())) {
            results.add({
              'name': name,
              'ingredients': ingredients,
              'recipe_id': key,
            });
          }
        });

        setState(() {
          searchResults = results;
        });
      }
    } catch (e) {
      print('Error searching recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter recipe name or ingredient',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  this.query = query;
                });
                _searchRecipes(query); // Tìm kiếm mỗi khi thay đổi từ khóa
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: searchResults.isEmpty
                  ? Center(child: Text('No results found.'))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(searchResults[index]['name']),
                          subtitle: Text(
                              'Ingredients: ${searchResults[index]['ingredients']}'),
                          onTap: () {
                            // Chuyển đến màn hình chi tiết với recipe_id
                            Navigator.pushNamed(
                              context,
                              '/recipe-details',
                              arguments: searchResults[index]['recipe_id'],
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
