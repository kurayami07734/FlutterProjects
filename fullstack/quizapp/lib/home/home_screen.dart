import 'package:flutter/material.dart';
import 'package:quizapp/login/login_screen.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/topics/topics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
      stream: AuthService().userStream,
    );
  }
}
