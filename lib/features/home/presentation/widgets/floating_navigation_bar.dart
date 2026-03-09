import 'dart:ui';

import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF5A6475).withValues(alpha: 0.5),
                  const Color(0xFF3E4758).withValues(alpha: 0.5),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem(Icons.home_outlined, Icons.home, 0),
                _buildItem(Icons.search, Icons.search, 1),
                _buildItem(Icons.person_outline, Icons.person, 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData iconOutlined, IconData iconFilled, int index) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? const Color(0xFF7CC2FF) : Colors.white70;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              isSelected ? iconFilled : iconOutlined,
              size: 26,
              color: color,
            ),
          ),
          if (isSelected)
            Positioned(
              bottom: -6,
              child: Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF7CC2FF),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}