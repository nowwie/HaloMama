import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';

// Model untuk item navbar
class NavBarItem {
  final IconData icon;
  final String label;
  final bool isCenter;

  NavBarItem({
    required this.icon,
    required this.label,
    this.isCenter = false,
  });
}

// Widget navbar yang reusable
class CustomBottomNavBar extends StatelessWidget {
  final List<NavBarItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final Color centerButtonColor;
  final double height;

  const CustomBottomNavBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = MyColors.normal,
    this.inactiveColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.centerButtonColor = MyColors.normal,
    this.height = 80.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Index item tengah
    final int centerIndex = items.indexWhere((e) => e.isCenter);

    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background navbar
          Container(
            height: height * 0.6,
            decoration: BoxDecoration(
              color: backgroundColor,
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
              children: items.map((item) {
                if (item.isCenter) return SizedBox(width: 60); // kosong untuk tengah
                int index = items.indexOf(item);
                bool isActive = currentIndex == index;
                return _buildRegularItem(item, isActive, index);
              }).toList(),
            ),
          ),

          // Floating center button
          if (centerIndex != -1)
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Center(
                child: _buildCenterItem(
                  items[centerIndex],
                  currentIndex == centerIndex,
                  centerIndex,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCenterItem(NavBarItem item, bool isActive, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: centerButtonColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: centerButtonColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          item.icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildRegularItem(NavBarItem item, bool isActive, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: isActive ? activeColor : inactiveColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
