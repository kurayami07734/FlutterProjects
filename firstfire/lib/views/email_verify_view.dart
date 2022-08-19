import 'package:firstfire/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import "../constants/routes.dart";

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({Key? key}) : super(key: key);

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify your email")),
      body: Center(
        child: Column(
          children: [
            Text("Please verify your email address"),
            TextButton(
              onPressed: () async {
                AuthService.fromFirebase().sendEmailVerification();
              },
              child: Text("Send verification email"),
            ),
            TextButton(
              onPressed: () async {
                if (AuthService.fromFirebase().currentUser != null) {
                  await AuthService.fromFirebase().logout();
                }
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: Text("Restart process"),
            )
          ],
        ),
      ),
    );
  }
}
