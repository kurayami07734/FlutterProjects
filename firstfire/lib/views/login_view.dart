import 'package:firebase_core/firebase_core.dart';
import '../constants/routes.dart';
import '../utils/show_error_dialog.dart';
import 'package:firstfire/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                        .signInWithEmailAndPassword(
                            email: _email.text, password: _password.text);
                    if (FirebaseAuth.instance.currentUser?.emailVerified ??
                        false) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute,
                        (_) => false,
                      );
                    }
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        emailVerifyRoute, (route) => false);
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "wrong-password":
                        {
                          await showErrorDialog(
                              context: context, errorMessage: "Wrong password");
                          break;
                        }
                      case "user-not-found":
                        {
                          await showErrorDialog(
                              context: context,
                              errorMessage: "User is not yet registed");
                          break;
                        }
                      default:
                        {
                          await showErrorDialog(
                              context: context,
                              errorMessage: "Error : ${e.code}");
                          break;
                        }
                    }
                  } catch (e) {
                    await showErrorDialog(
                        context: context, errorMessage: e.toString());
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
