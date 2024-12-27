// screens/about_support_screen.dart
import 'package:flutter/material.dart';

class AboutSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giới thiệu & Hỗ trợ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Về ứng dụng',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Bartender Guide là người bạn đồng hành giúp bạn thành thạo công thức pha chế đồ uống.'),
            SizedBox(height: 20),
            Text(
              'Hỗ trợ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Để được hỗ trợ, hãy liên hệ với chúng tôi theo địa chỉ: longdj2003@gmail.com'),
          ],
        ),
      ),
    );
  }
}
