import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/pages/settings/ContentSettings.dart';
import 'package:flutter_application_1/components/ui/dropdown/NotificationDropdown.dart';
import 'package:flutter_application_1/components/ui/dropdown/UserNotificationDropdown.dart';

import 'package:flutter_application_1/components/ui/layout/Footer.dart';
import 'package:flutter_application_1/components/ui/layout/Header.dart';
import 'package:flutter_application_1/components/ui/navigation/BottomNavigation.dart';
import 'package:flutter_application_1/components/ui/navigation/Drawer.dart';
import 'package:flutter_application_1/components/ui/navigation/Sidebar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingScreeenState createState() => _SettingScreeenState();
}

class _SettingScreeenState extends State<SettingsScreen> {
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
              title: const Text('Point of Sale'),
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
                  child: ContentSettings(isMobile: isMobile),
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
