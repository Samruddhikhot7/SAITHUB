import 'package:flutter/material.dart';
import 'home_page.dart';
import 'report_page.dart';
import 'notification_page.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ReportPage(),
    NotificationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean background
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _navBarItem(Icons.home, 'Home', 0),
          _navBarItem(Icons.article, 'Reports', 1),
          _navBarItem(Icons.notifications, 'Notifications', 2),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.indigo.shade200,
        backgroundColor: Colors.indigo.shade900, // Solid navy blue navbar
        elevation: 5,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem _navBarItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 28),
      label: label,
    );
  }
}
