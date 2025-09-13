import 'package:flutter/material.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/dashbord/analyse_screen.dart';
import 'package:my_profile/screen/dashbord/dashbord_info_screen.dart';
import 'package:my_profile/screen/dashbord/profile_settings_screen.dart';
import 'package:my_profile/screen/dashbord/project_dashbord_screen.dart';
import 'package:my_profile/screen/widget/sidebar_dashbord.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int isSelected = 0;
  updateScreen(int index) {
    setState(() {
      isSelected = index;
      _pageController.jumpToPage(index);
    });
  }

  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const DashbordInfoScreen(),
    const ProjectDashbordScreen(),
    const AnalyzeScreen(),
    ProfileSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      body: Row(
        children: [
          // Sidebar
          SidebarDashboard(isSelected: isSelected, updateScreen: updateScreen),
          // Main content area
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width - 250,
            child: PageView(
              controller: _pageController,
              children: _pages,
              // تمكين التمرير إذا أراد المستخدم السحب اليدوي مع الاحتفاظ بسلاسة الانتقال
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
