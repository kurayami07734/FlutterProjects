import 'package:flutter/material.dart';
import 'package:quizapp/shared/bottom_navbar.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
