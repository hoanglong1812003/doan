import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()), // Dịch chuỗi "settings"
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('changeLanguage'.tr()), // Dịch chuỗi "changeLanguage"
            onTap: () {
              _showLanguageDialog(context);
            },
          ),
          ListTile(
            title: Text('changeTheme'.tr()), // Dịch chuỗi "changeTheme"
            onTap: () {
              // Logic để thay đổi giao diện (light/dark mode)
            },
          ),
          ListTile(
            title: Text('changeUnits'.tr()), // Dịch chuỗi "changeUnits"
            onTap: () {
              // Logic để thay đổi đơn vị
            },
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị Dialog để chọn ngôn ngữ
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('chooseLanguage'.tr()), // Dịch chuỗi "chooseLanguage"
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  context.setLocale(Locale('en')); // Chuyển ngôn ngữ sang tiếng Anh
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
              ListTile(
                title: Text('Tiếng Việt'),
                onTap: () {
                  context.setLocale(Locale('vi')); // Chuyển ngôn ngữ sang tiếng Việt
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
