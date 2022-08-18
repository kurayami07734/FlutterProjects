import 'package:flutter/material.dart';

Future<bool> showLogoutDialog({required BuildContext context}) {
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
