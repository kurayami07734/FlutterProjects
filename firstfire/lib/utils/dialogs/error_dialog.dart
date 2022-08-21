import 'package:flutter/material.dart';
import './generic_dialog.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String content,
}) {
  return showGenericDialog(
    context: context,
    title: "An error occurred",
    content: content,
    optionBuilder: () => {
      "OK": null,
    },
  );
}
