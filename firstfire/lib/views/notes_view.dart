import 'package:firebase_core/firebase_core.dart';
import 'package:firstfire/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login/", (_) => false);
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

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sign out"),
          content: Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel")),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Log out")),
          ],
        );
      }).then((value) => value ?? false);
}
