import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/pages/dashboard/ContentDashboard.dart';
import 'package:flutter_application_1/components/ui/dropdown/NotificationDropdown.dart';
import 'package:flutter_application_1/components/ui/dropdown/UserNotificationDropdown.dart';
import 'package:flutter_application_1/components/pages/pos/Content.dart';
import 'package:flutter_application_1/components/ui/layout/Footer.dart';
import 'package:flutter_application_1/components/ui/layout/Header.dart';
import 'package:flutter_application_1/components/ui/navigation/BottomNavigation.dart';
import 'package:flutter_application_1/components/ui/navigation/Drawer.dart';
import 'package:flutter_application_1/components/ui/navigation/Sidebar.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSidebarExpanded = false;
  bool isHovered = false;

@override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    bool isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
    bool isDesktop = MediaQuery.of(context).size.width >= 1024 &&
        MediaQuery.of(context).size.width < 1440;
    bool isLargeDesktop = MediaQuery.of(context).size.width >= 1440;

    return Scaffold(
      appBar: isMobile || isTablet
          ? AppBar(
              title: const Text('Dashboard'),
              actions: [
                NotificationDropdown(),
                UserDropdown(),
              ],
            )
          : null,
      drawer: isMobile || isTablet
          ? CustomDrawer()
          : null,
      body: Row(
        children: [
          if (isDesktop || isLargeDesktop)
           Sidebar(
            isSidebarExpanded: isSidebarExpanded,
            onToggle: () {
              setState(() {
                isSidebarExpanded = !isSidebarExpanded;
              });
            },
          ),
          Expanded(
            child: Column(
              children: [
                if (isDesktop || isLargeDesktop) Header(),
                Expanded(
                  child: ContentDashboard(isMobile: isMobile),
                ),
                Footer(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile || isTablet
        ? CustomBottomNavigationBar()
        : null,
    );
  }
 }
