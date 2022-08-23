import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';
import '../constants/routes.dart';
import '../utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController(),
      _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: FutureBuilder(
        future: AuthService.fromFirebase().initialize(),
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                controller: _email,
                decoration: const InputDecoration(hintText: "Email"),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _password,
                decoration: const InputDecoration(hintText: "Password"),
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await AuthService.fromFirebase().login(
                      email: _email.text,
                      password: _password.text,
                    );
                    if (AuthService.fromFirebase()
                            .currentUser
                            ?.isEmailVerified ??
                        false) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute,
                        (_) => false,
                      );
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          emailVerifyRoute, (route) => false);
                    }
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                        context: context,
                        content: "User is not yet registered");
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                        context: context, content: "Wrong password");
                  } on GenericAuthException {
                    await showErrorDialog(
                        context: context, content: "failed to login");
                  }
                },
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text("New User? Register here!"),
              ),
            ],
          );
        },
      ),
    );
  }
}
