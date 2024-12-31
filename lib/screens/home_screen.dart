import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Danh sách các mục trong giao diện
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.search, 'label': 'Tìm kiếm', 'route': '/search'},
      {'icon': Icons.category, 'label': 'Thể loại', 'route': '/categories'},
      {'icon': Icons.favorite, 'label': 'Yêu thích', 'route': '/favorites'},
      {'icon': Icons.add, 'label': 'Tạo công thức', 'route': '/create-recipe'},
      {'icon': Icons.school, 'label': 'Hướng dẫn', 'route': '/basic-tutorials'},
      {'icon': Icons.lightbulb, 'label': 'Gợi ý đồ uống', 'route': '/drink-suggestions'},
      {'icon': Icons.calculate, 'label': 'Máy tính', 'route': '/ingredient-calculator'},
      {'icon': Icons.share, 'label': 'Chia sẻ', 'route': '/share-recipe'},
      {'icon': Icons.settings, 'label': 'Cài đặt', 'route': '/settings'},
      {'icon': Icons.info, 'label': 'Giới thiệu', 'route': '/about-support'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Bartender ',
                style: TextStyle(
                  fontSize: 24, // Kích thước chữ
                  fontWeight: FontWeight.bold, // Chữ đậm
                  color: Colors.deepOrange, // Màu chữ
                ),
              ),
              TextSpan(
                text: 'Guide',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow, // Màu chữ nổi bật
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số lượng cột
            crossAxisSpacing: 12, // Khoảng cách giữa các cột
            mainAxisSpacing: 12, // Khoảng cách giữa các hàng
            childAspectRatio: 1, // Tỉ lệ khung hình
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, item['route']);
              },
              child: Card(
                elevation: 4, // Hiệu ứng đổ bóng
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bo tròn góc
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 48, color: Theme.of(context).primaryColor),
                    SizedBox(height: 8),
                    Text(
                      item['label'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
