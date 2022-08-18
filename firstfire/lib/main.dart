import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfire/views/notes_view.dart';
import 'views/register_view.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';
import 'views/email_verify_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      routes: {
        "/login/": (context) => LoginView(),
        "/register/": (context) => RegisterView(),
        "/emailVerify/": (context) => EmailVerifyView(),
        "/notes/": (context) => NotesView(),
      },
    );
  }
}
