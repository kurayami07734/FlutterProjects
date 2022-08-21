import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';
import '../utils/dialogs/error_dialog.dart';
import '../constants/routes.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _email = TextEditingController(),
      _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
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
                    final userCredentials = await AuthService.fromFirebase()
                        .createUser(
                            email: _email.text, password: _password.text);
                    Navigator.of(context).pushNamed(emailVerifyRoute);
                  } on WeakPasswordAuthException {
                    await showErrorDialog(
                      context: context,
                      content: "Password is weak",
                    );
                  } on InvalidEmailAuthException {
                    await showErrorDialog(
                      context: context,
                      content: "valid email is required",
                    );
                  } on EmailAlreadyInUseAuthException {
                    await showErrorDialog(
                      context: context,
                      content: "Email is already in use",
                    );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context: context,
                      content: "failed to register",
                    );
                  }
                },
                child: Text("Register"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: Text("Already registered? Login here"),
              )
            ]);
          }),
    );
  }
}
