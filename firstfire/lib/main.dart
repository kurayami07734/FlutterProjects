import 'package:firstfire/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firstfire/services/auth/firebase_auth_provider.dart';
import 'views/notes/notes_view.dart';
import 'views/notes/create_update_note_view.dart';
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
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Notes App',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomeView(),
      ),
      routes: {
        loginRoute: (_) => const LoginView(),
        registerRoute: (_) => const RegisterView(),
        emailVerifyRoute: (_) => const EmailVerifyView(),
        notesRoute: (_) => const NotesView(),
        createUpdateNoteRoute: (_) => const CreateUpdateNoteView(),
      },
    );
  }
}
