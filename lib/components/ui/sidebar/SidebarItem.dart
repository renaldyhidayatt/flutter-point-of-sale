import 'package:flutter/material.dart';

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSidebarExpanded;

  const SidebarItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSidebarExpanded,
  }) : super(key: key);

  @override
  _SidebarItemState createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
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
            Icon(widget.icon, color: Colors.white, size: 24),
            if (widget.isSidebarExpanded) const SizedBox(width: 16),
            if (widget.isSidebarExpanded)
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
