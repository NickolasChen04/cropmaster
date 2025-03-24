import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'farm_map_page.dart';
import 'settings_page.dart';
import '../providers/navigation_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> _pages = [
    const HomePage(),
    const FarmMapPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF4ADE80),
          body: _pages[navigationProvider.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: GNav(
                backgroundColor: Colors.white,
                activeColor: const Color(0xFF4ADE80),
                tabBackgroundColor: Colors.grey[100]!,
                gap: 8,
                iconSize: 24,
                padding: const EdgeInsets.all(14),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home'
                  ),
                  GButton(
                    icon: Icons.agriculture,
                    text: 'Your Farms'
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings'
                  ),
                ],
                selectedIndex: navigationProvider.currentIndex,
                onTabChange: (index) {
                  navigationProvider.setIndex(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
} 