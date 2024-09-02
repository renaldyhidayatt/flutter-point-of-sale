import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/pages/note/ContentNote.dart';
import 'package:flutter_application_1/components/ui/dropdown/NotificationDropdown.dart';
import 'package:flutter_application_1/components/ui/dropdown/UserNotificationDropdown.dart';

import 'package:flutter_application_1/components/ui/layout/Footer.dart';
import 'package:flutter_application_1/components/ui/layout/Header.dart';
import 'package:flutter_application_1/components/ui/navigation/Drawer.dart';
import 'package:flutter_application_1/components/ui/navigation/Sidebar.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
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
              title: const Text('NoteList'),
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
                  child: ContentNoteList(isTablet: isTablet, isDesktop: isDesktop, isLargeDesktop: isLargeDesktop,),
                ),
                Footer(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile || isTablet
        ? BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard, color: Colors.black),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.folder, color: Colors.black),
                label: 'Projects',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics, color: Colors.black),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment, color: Colors.black),
                label: 'POS',
              ),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            onTap: (index) {
            
            },
          )
        : null,
    );
  }
 }
