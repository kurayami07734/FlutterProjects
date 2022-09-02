import 'package:firstfire/helpers/loading/loading_screen.dart';
import 'package:firstfire/services/auth/bloc/auth_state.dart';
import 'package:firstfire/views/forgot_password_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import './notes/notes_view.dart';
import './login_view.dart';
import './email_verify_view.dart';
import 'package:flutter/material.dart';
import 'register_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsEmailVerification) {
          return const EmailVerifyView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? "Please wait",
          );
        } else {
          LoadingScreen().hide();
        }
      },
    );
  }
}
