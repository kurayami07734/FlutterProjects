import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfire/views/email_verify_view.dart';
import './notes_view.dart';
import './register_view.dart';
import './login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              final user = FirebaseAuth.instance.currentUser;
              final isVerified = user?.emailVerified ?? false;
              if (user == null) return RegisterView();
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
