import 'package:firstfire/utils/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showLogoutDialog({required BuildContext context}) async {
  return showGenericDialog(
      context: context,
      title: "Logout",
      content: "Are you sure you want to logout?",
      optionBuilder: () => {
            "Cancel": false,
            "Log out": true,
          }).then(
    (value) => value ?? false,
  );
}
