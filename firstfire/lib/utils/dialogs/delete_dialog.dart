import 'package:flutter/material.dart';
import './generic_dialog.dart';

Future<bool> showDeleteDialog({required BuildContext context}) async {
  return showGenericDialog(
      context: context,
      title: "Deleting Note",
      content: "Are you sure you want to delete this note?",
      optionBuilder: () => {
            "Cancel": false,
            "Yes": true,
          }).then(
    (value) => value ?? false,
  );
}
