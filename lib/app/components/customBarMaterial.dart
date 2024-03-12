import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBarMaterial extends StatelessWidget {

  final Color colorIcon = const Color(0xFFFFFFFF);
  final Color colorSelect = const Color(0xFFEA1818);
  final Color colorBackground = const Color(0xFF1B1B1D);
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color colorIcon= Color(0xFFFFFFFF);
    const Color colorSelect= Color(0xFF260534);
    const Color colorBackground= Color(0xFF989898);

    return BottomNavigationBar(
      unselectedItemColor: colorBackground,
      selectedItemColor: colorSelect,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorIcon,
      selectedFontSize: 16,
      selectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600
      ),
      iconSize: 24,
      showUnselectedLabels: true,
      items: [
        _bottomNavigationBarItem(
          icon: CupertinoIcons.house_fill,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: CupertinoIcons.search_circle_fill,
          label: 'Search',
        ),
        _bottomNavigationBarItem(
          icon: CupertinoIcons.bookmark_fill,
          label: 'Bookmark',
        ),
        _bottomNavigationBarItem(
          icon: CupertinoIcons.person_circle_fill,
          label: 'Profile',
        ),
      ],
    );
  }
  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
