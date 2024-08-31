import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final bool isSidebarExpanded;
  final VoidCallback onToggle;

  const Sidebar({Key? key, required this.isSidebarExpanded, required this.onToggle}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isHovered = false;

  Widget _buildSidebarItem(IconData icon, String title, {bool hasChildren = false}) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (widget.isSidebarExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(icon, color: Colors.white, size: 24),
              )
            else
              Expanded(
                child: Icon(icon, color: Colors.white, size: 24),
              ),
            if (widget.isSidebarExpanded) const SizedBox(width: 16),
            if (widget.isSidebarExpanded)
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            if (hasChildren && widget.isSidebarExpanded)
              const Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isSidebarExpanded ? 250 : 70,
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: widget.onToggle,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  // Dashboards
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: widget.isSidebarExpanded ? 16 : 8),
                    title: _buildSidebarItem(Icons.pie_chart, 'Dashboards'),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: widget.isSidebarExpanded ? 16 : 8),
                    title: _buildSidebarItem(Icons.point_of_sale, 'Point Of Sale'),
                    onTap: () {
                      Navigator.pushNamed(context, '/pos');
                    },
                  ),
                  // Projects Group
                  if (widget.isSidebarExpanded)
                    ExpansionTile(
                      title: _buildSidebarItem(Icons.folder, 'Projects', hasChildren: true),
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 40),
                          title: _buildSidebarItem(Icons.work, 'Projects'),
                          onTap: () {
                            // Navigate to /proyek/project
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 40),
                          title: _buildSidebarItem(Icons.group, 'Clients'),
                          onTap: () {
                            // Navigate to /proyek/client
                          },
                        ),
                      ],
                    )
                  else
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      title: _buildSidebarItem(Icons.folder, 'Projects'),
                      onTap: () {
                        // Handle tap for Projects when sidebar is collapsed
                      },
                    ),
                  // Add more widgets as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}