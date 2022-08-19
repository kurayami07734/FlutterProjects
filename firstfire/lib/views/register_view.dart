import 'package:firebase_core/firebase_core.dart';
import '../utils/show_error_dialog.dart';
import '../constants/routes.dart';
import 'package:firstfire/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
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
                    final userCredentials = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email.text, password: _password.text);
                    Navigator.of(context).pushNamed(emailVerifyRoute);
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "weak-password":
                        {
                          await showErrorDialog(
                              context: context,
                              errorMessage: "Password is weak");
                          break;
                        }
                      case "invalid-email":
                        {
                          await showErrorDialog(
                              context: context,
                              errorMessage: "valid email is required");
                          break;
                        }
                      default:
                        {
                          await showErrorDialog(
                              context: context,
                              errorMessage: "Error: ${e.code}");
                          break;
                        }
                    }
                  } catch (e) {
                    await showErrorDialog(
                        context: context, errorMessage: e.toString());
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
