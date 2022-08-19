import 'views/notes_view.dart';
import 'views/register_view.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';
import 'views/email_verify_view.dart';
import 'package:flutter/material.dart';
import 'constants/routes.dart';

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
        loginRoute: (_) => LoginView(),
        registerRoute: (_) => RegisterView(),
        emailVerifyRoute: (_) => EmailVerifyView(),
        notesRoute: (_) => NotesView(),
      },
    );
  }
}
