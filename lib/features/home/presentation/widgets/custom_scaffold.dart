import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body, this.appBar});

  final Widget body;
  final Widget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.2,
                colors: [Color(0xFF111827), Color(0xFF030712)],
              ),
            ),
          ),
          SafeArea(child: Column(
          children: [
          appBar ?? Container(),
          Expanded(child: body),
          ],),),
        ],
      ),
    );
  }
}
