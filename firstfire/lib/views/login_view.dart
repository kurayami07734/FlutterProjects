import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';
import '../constants/routes.dart';
import '../utils/show_error_dialog.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController(),
      _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: FutureBuilder(
          future: AuthService.fromFirebase().initialize(),
          builder: (context, snapshot) {
            return Column(children: [
              TextField(
                controller: _email,
                decoration: InputDecoration(hintText: "Email"),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _password,
                decoration: InputDecoration(hintText: "Password"),
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final userCredentials =
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
                        errorMessage: "User is not yet registed");
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                        context: context, errorMessage: "Wrong password");
                  } on GenericAuthException {
                    await showErrorDialog(
                        context: context, errorMessage: "failed to login");
                  }
                },
                child: Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: Text("New User? Register here!"),
              ),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(emailVerifyRoute),
                  child: Text("Verify your email here"))
            ]);
          }),
    );
  }
}
