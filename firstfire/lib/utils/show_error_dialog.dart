import 'package:flutter/material.dart';

Future<void> showErrorDialog(
    {required BuildContext context, required String errorMessage}) {
  return showDialog<void>(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text("An error occurred"),
          content: Text(errorMessage),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        );
      })).then((value) => null);
}
