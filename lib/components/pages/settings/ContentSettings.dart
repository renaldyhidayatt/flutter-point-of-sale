import 'package:flutter/material.dart';

class ContentSettings extends StatelessWidget {
  final bool isMobile;

  const ContentSettings({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildSettingItem('Account', Icons.person, isMobile),
          _buildSettingItem('Notifications', Icons.notifications, isMobile),
          _buildSettingItem('Privacy', Icons.lock, isMobile),
          _buildSettingItem('Language', Icons.language, isMobile),
          _buildSettingItem('Help & Support', Icons.help, isMobile),
          _buildSettingItem('About', Icons.info, isMobile),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, bool isMobile) {
    return ListTile(
      leading: Icon(icon, size: isMobile ? 24 : 28),
      title: Text(
        title,
        style: TextStyle(
          fontSize: isMobile ? 16 : 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: isMobile ? 16 : 20),
      onTap: () {
        // Tambahkan logika navigasi atau aksi di sini
      },
    );
  }
}
