import 'package:flutter/material.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/home_screen.dart';

class SidebarDashboard extends StatelessWidget {
  const SidebarDashboard({
    Key? key,
    required this.isSelected,
    required this.updateScreen,
  }) : super(key: key);
  final int isSelected;
  final ValueChanged<int> updateScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: AppConstant.panelColor, // Slightly darker sidebar color
      child: Column(
        children: [
          // Logo/App name
          SizedBox(
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Navigation items
          GestureDetector(
            onTap: () {
              updateScreen(0);
            },
            child: _SidebarItem(
              icon: Icons.home,
              label: 'Dashboard',
              isSelected: (isSelected == 0),
            ),
          ),
          GestureDetector(
            onTap: () {
              updateScreen(1);
            },
            child: _SidebarItem(
              icon: Icons.folder_open,
              label: 'Projects',
              isSelected: (isSelected == 1),
            ),
          ),
          GestureDetector(
            onTap: () {
              updateScreen(2);
            },
            child: _SidebarItem(
              icon: Icons.analytics,
              label: 'Analytics',
              isSelected: (isSelected == 2),
            ),
          ),
          GestureDetector(
            onTap: () {
              updateScreen(3);
            },
            child: _SidebarItem(
              icon: Icons.settings,
              label: 'Settings',
              isSelected: (isSelected == 3),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: _SidebarItem(icon: Icons.person, label: 'Profile'),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  _SidebarItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
