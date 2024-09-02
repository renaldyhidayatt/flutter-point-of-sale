import 'package:flutter/material.dart';

class UserDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      icon: CircleAvatar(
        backgroundImage:
            AssetImage('assets/luffy.jpg'), // Ganti dengan gambar lokal
        radius: 20, // Sesuaikan ukuran avatar
        backgroundColor:
            Colors.transparent, // Menyembunyikan latar belakang default
        // Gunakan fit untuk mengatur cara gambar ditampilkan di avatar
        child: ClipOval(
          child: Image.asset(
            'assets/luffy.jpg',
            width: 40, // Sesuaikan lebar gambar
            height: 40, // Sesuaikan tinggi gambar
            fit: BoxFit.cover, // Memastikan gambar tidak pecah
          ),
        ),
      ),
      onSelected: (value) {
        _onMenuSelection(value, context);
      },
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: ListTile(
            leading: Icon(Icons.person, color: Color.fromARGB(255, 37, 37, 37)),
            title: Text('Profile'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            leading:
                Icon(Icons.settings, color: Color.fromARGB(255, 37, 37, 37)),
            title: Text('Settings'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: ListTile(
            leading: Icon(Icons.logout, color: Color.fromARGB(255, 37, 37, 37)),
            title: Text('Logout'),
          ),
        ),
      ],
    );
  }

  void _onMenuSelection(int value, BuildContext context) {
    switch (value) {
      case 0:
        Navigator.pushNamed(context, '/profile');
        break;
      case 1:
        _showAlertDialog('Settings page is not implemented yet.', context);
        break;
      case 2:
        _showAlertDialog('Do you want to logout?', context,
            onLogoutConfirmed: () {
          Navigator.pushReplacementNamed(context, '/login');
        });
        break;
      default:
        break;
    }
  }

  void _showAlertDialog(String message, BuildContext context,
      {VoidCallback? onLogoutConfirmed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onLogoutConfirmed != null) {
                  onLogoutConfirmed();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
