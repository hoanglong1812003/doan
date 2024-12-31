import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favoriteRecipes = [];
  List<String> allDrinkNames = []; // Lưu trữ tất cả đồ uống từ Firebase
  final TextEditingController drinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFavorites();
    fetchAllDrinks(); // Lấy danh sách đồ uống để gợi ý
  }

  Future<void> fetchFavorites() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .get();

      setState(() {
        favoriteRecipes = snapshot.docs
            .map((doc) => doc['name'] as String)
            .toList();
      });
    } catch (e) {
      print('Lỗi khi tải danh sách yêu thích: $e');
    }
  }

  Future<void> fetchAllDrinks() async {
    try {
      final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('drinks').get();

      setState(() {
        allDrinkNames = snapshot.docs
            .map((doc) => doc['name'] as String)
            .toList();
      });
    } catch (e) {
      print('Lỗi khi tải danh sách đồ uống: $e');
    }
  }

  Future<void> addFavorite(String name) async {
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập tên đồ uống!')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('favorites').add({
        'name': name,
        'added_at': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã thêm vào danh sách yêu thích!')),
      );
      fetchFavorites();
    } catch (e) {
      print('Lỗi khi thêm vào danh sách yêu thích: $e');
    }
  }

  Future<void> deleteFavorite(String name) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('name', isEqualTo: name)
          .get();

      for (var doc in snapshot.docs) {
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(doc.id)
            .delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xóa khỏi danh sách yêu thích!')),
      );
      fetchFavorites();
    } catch (e) {
      print('Lỗi khi xóa khỏi danh sách yêu thích: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mục yêu thích'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return allDrinkNames.where((drink) => drink
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (String selection) {
                    drinkController.text = selection;
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Tên đồ uống',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    addFavorite(drinkController.text.trim());
                    drinkController.clear();
                  },
                  child: Text('Thêm'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoriteRecipes[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deleteFavorite(favoriteRecipes[index]);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/recipe-details',
                        arguments: favoriteRecipes[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
