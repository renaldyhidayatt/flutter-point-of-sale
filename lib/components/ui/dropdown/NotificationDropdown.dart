import 'package:flutter/material.dart';

class NotificationDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 37, 37, 37)),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: ListTile(
            leading: const Icon(Icons.message, color: Colors.blue),
            title: const Text('New comment on your post'),
            subtitle: const Text('5 mins ago'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.person_add, color: Colors.green),
            title: Text('New follower'),
            subtitle: Text('12 mins ago'),
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.orange),
            title: const Text('Order #1234 confirmed'),
            subtitle: const Text('30 mins ago'),
          ),
        ),
      ],
      onSelected: (item) {
        // Handle notification item click
      },
    );
  }
}
