import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "IMDUMB",
              style: TextStyle(fontSize: 80, fontFamily: 'Junegull'),
            ),
            Text("IMDUMB"),
            Text("IMDUMB is a new way to watch movies and TV shows."),
          ],
        ),
      ),
    );
  }
}