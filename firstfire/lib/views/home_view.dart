import 'dart:developer';

import '../services/auth/auth_service.dart';
import './notes_view.dart';
import './login_view.dart';
import './email_verify_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.fromFirebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              final user = AuthService.fromFirebase().currentUser;
              final isVerified = user?.isEmailVerified ?? false;
              log(isVerified.toString());
              if (user == null) return LoginView();
              if (!isVerified) return EmailVerifyView();
              return NotesView();
            }
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
