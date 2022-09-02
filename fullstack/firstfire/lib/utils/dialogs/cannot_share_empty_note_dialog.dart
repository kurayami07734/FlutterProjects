import './generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Error occurred",
    content: "Cannot share empty note",
    optionBuilder: () => {
      "ok": null,
    },
  );
}
