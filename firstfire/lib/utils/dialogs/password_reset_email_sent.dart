import 'package:firstfire/utils/dialogs/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Password reset",
    content: "We've sent you an email to reset your password",
    optionBuilder: () => {
      "ok": null,
    },
  );
}
