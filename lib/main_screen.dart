import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';
import 'package:halomama/components/navbar.dart';
import 'package:halomama/pages/user/activity_page.dart';
import 'package:halomama/pages/user/dashboard.dart';
import 'package:halomama/pages/user/maya_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  void goToPage(int index) {
  setState(() {
    _currentIndex = index;
  });
}


  final List<NavBarItem> _navItems = [
    NavBarItem(icon: Icons.home_outlined, label: 'Home'),
    NavBarItem(icon: Icons.add_chart_outlined, label: 'Activity'),
    NavBarItem(icon: Icons.chat_bubble_outline_outlined, label: 'Maya', isCenter: true),
    NavBarItem(icon: Icons.bar_chart_outlined, label: 'Report'),
    NavBarItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  List<Widget> get _pages => [
    HomeContent(onChatNow: () => goToPage(2)),
    ActivityPage(),
    MayaPage(),
    // ReportPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    _navItems.map((item) {
                      if (item.isCenter) return const SizedBox(width: 60);
                      int index = _navItems.indexOf(item);
                      bool isActive = _currentIndex == index;
                      return _buildRegularItem(item, isActive, index);
                    }).toList(),
              ),
            ),
            // Floating center button
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Center(
                child: _buildCenterItem(
                  _navItems.firstWhere((e) => e.isCenter),
                  _currentIndex == _navItems.indexWhere((e) => e.isCenter),
                  _navItems.indexWhere((e) => e.isCenter),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterItem(NavBarItem item, bool isActive, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: MyColors.normal,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: MyColors.normal.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(item.icon, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildRegularItem(NavBarItem item, bool isActive, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: FittedBox(
          fit: BoxFit.scaleDown, 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item.icon,
                color: isActive ? MyColors.normal : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                style: TextStyle(
                  color: isActive ? MyColors.normal : Colors.grey,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
