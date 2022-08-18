import 'package:firebase_core/firebase_core.dart';
import 'package:firstfire/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfire/views/register_view.dart';
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
                    print(userCredentials);
                  } on FirebaseAuthException catch (e) {
                    print(e.toString());
                  }
                },
                child: Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/register/",
                    (route) => false,
                  );
                },
                child: Text("New User? Register here!"),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          "/emailVerify/", (route) => false),
                  child: Text("Verify your email here"))
            ]);
          }),
    );
  }
}
