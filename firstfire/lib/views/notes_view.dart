import '../constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/show_logout_dialog.dart';
import 'dart:developer' as dev show log;

enum MenuActions { logout, login, register, verifyEmail }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        actions: [
          PopupMenuButton<MenuActions>(
            onSelected: (e) async {
              switch (e) {
                case MenuActions.logout:
                  final shouldLogout = await showLogoutDialog(context: context);
                  if (shouldLogout) {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
                  dev.log(shouldLogout.toString());
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuActions>(
                  value: MenuActions.logout,
                  child: Text("Logout"),
                ),
                PopupMenuItem<MenuActions>(
                  value: MenuActions.login,
                  child: Text("Login"),
                ),
                PopupMenuItem<MenuActions>(
                  value: MenuActions.register,
                  child: Text("Register"),
                ),
                PopupMenuItem<MenuActions>(
                  value: MenuActions.verifyEmail,
                  child: Text("Verify Email"),
                ),
              ];
            },
          )
        ],
      ),
      // body: FutureBuilder(
      //   future: Firebase.initializeApp(
      //     options: DefaultFirebaseOptions.currentPlatform,
      //   ),
      //   builder: ((context, snapshot) {}),
      // ),
    );
  }
}
