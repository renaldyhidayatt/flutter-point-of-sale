import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xFF1977FC),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSidebarExpanded = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: const Text('Ecommerce Dashboard'),
              actions: [
                _buildNotificationDropdown(),
                _buildUserDropdown(),
              ],
            )
          : null,
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1977FC),
                    ),
                    child: const Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Dashboard'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.folder),
                    title: const Text('Projects'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.analytics),
                    title: const Text('Analytics'),
                    onTap: () {},
                  ),
                ],
              ),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSidebarExpanded ? 250 : 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF1977FC),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: isHovered ? 1 : 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          isSidebarExpanded = !isSidebarExpanded;
                        });
                      },
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          const SizedBox(height: 20),
                          _buildSidebarItem(Icons.dashboard, "Dashboard"),
                          const SizedBox(height: 20),
                          _buildSidebarItem(Icons.folder, "Projects"),
                          const SizedBox(height: 20),
                          _buildSidebarItem(Icons.analytics, "Analytics"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) _buildHeader(),
                Expanded(
                  child: _buildContent(context),
                ),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.folder),
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics),
                  label: 'Analytics',
                ),
              ],
              onTap: (index) {
                // Handle tab selection
              },
            )
          : null,
    );
  }

  Widget _buildNotificationDropdown() {
    return PopupMenuButton<int>(
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
        PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            leading: const Icon(Icons.person_add, color: Colors.green),
            title: const Text('New follower'),
            subtitle: const Text('12 mins ago'),
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

  Widget _buildUserDropdown() {
  return PopupMenuButton<int>(
    icon: const Icon(Icons.account_circle, color: Color.fromARGB(255, 37, 37, 37)),
    itemBuilder: (context) => [
      PopupMenuItem<int>(
        value: 0,
        child: ListTile(
          leading: const Icon(Icons.person, color: Color.fromARGB(255, 37, 37, 37)),
          title: const Text('Profile'),
        ),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: ListTile(
          leading: const Icon(Icons.help, color: Color.fromARGB(255, 37, 37, 37)),
          title: const Text('Help Center'),
        ),
      ),
      PopupMenuItem<int>(
        value: 2,
        child: ListTile(
          leading: const Icon(Icons.logout, color: Color.fromARGB(255, 37, 37, 37)),
          title: const Text('Logout'),
        ),
      ),
    ],
    onSelected: (item) {
      // Handle user menu item click
      switch (item) {
        case 0:
          // Navigate to Profile
          break;
        case 1:
          // Navigate to Help Center
          break;
        case 2:
          // Handle Logout
          break;
      }
    },
  );
}


  Widget _buildSidebarItem(IconData icon, String title) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                if (isSidebarExpanded) const SizedBox(width: 16),
                if (isSidebarExpanded)
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text("Ecommerce Dashboard", style: TextStyle(fontSize: 24)),
          const Spacer(),
          _buildNotificationDropdown(),
          const SizedBox(width: 16),
          _buildUserDropdown(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount;

    if (width >= 1200) {
      // Large Desktop
      crossAxisCount = 4;
    } else if (width >= 800) {
      // Desktop/Tablet
      crossAxisCount = 2;
    } else {
      // Mobile
      crossAxisCount = 1;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: _buildCards(),
      ),
    );
  }

  List<Widget> _buildCards() {
    return [
      _buildCard('Visitors', '\$20,149', 6),
      _buildCard('Customers', '\$5,834', -12),
      _buildCard('Orders', '\$3,270', 10),
      _buildCard('Sales', '\$1.324K', 2),
    ];
  }

  Widget _buildCard(String title, String amount, int percentage) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(amount, style: const TextStyle(fontSize: 24)),
            Row(
              children: [
                Icon(
                  percentage > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  color: percentage > 0 ? Colors.green : Colors.red,
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    color: percentage > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: const Center(
        child: Text("© 2024 Your Company"),
      ),
    );
  }
}
