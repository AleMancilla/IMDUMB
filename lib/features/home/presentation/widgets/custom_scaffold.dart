import 'package:flutter/material.dart';
import 'package:imdumb/features/home/presentation/widgets/floating_navigation_bar.dart';

const double kFloatingNavBarHeight = 70 + 20 * 2; 

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.selectedIndex,
    this.onNavTap,
  });

  final Widget body;
  final Widget? appBar;

  final int? selectedIndex;
  final ValueChanged<int>? onNavTap;

  bool get _showNavBar => selectedIndex != null && onNavTap != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                radius: 1.2,
                colors: [Color(0xFF111827), Color(0xFF030712)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                appBar ?? const SizedBox.shrink(),

                Expanded(child: body),
              ],
            ),
          ),
          if (_showNavBar)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingNavBar(
                  selectedIndex: selectedIndex!,
                  onTap: onNavTap!,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
