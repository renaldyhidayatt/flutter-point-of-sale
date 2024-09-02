import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1977FC),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Non-grouped items
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(), // Divider between non-grouped and grouped items

          // Grouped items
          ExpansionTile(
            leading: const Icon(Icons.folder),
            title: const Text('Projects'),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('New Project'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/projects/new');
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('Project List'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/projects/list');
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Analytics'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/analytics');
            },
          ),
        ],
      ),
    );
  }
}
