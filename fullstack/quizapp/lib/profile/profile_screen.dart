import 'package:flutter/material.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          await AuthService().signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
        child: const Text('sign out'),
      )),
    );
  }
}
