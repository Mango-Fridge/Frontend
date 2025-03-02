import 'package:flutter/material.dart';

// home_view BottomNavigationBar에서 활용하기 위한 모델
class NavItem {
  final IconData activeIcon;
  final String label;

  const NavItem({required this.activeIcon, required this.label});
}
