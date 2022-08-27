import 'package:firstfire/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../services/auth/bloc/auth_event.dart';

class EmailVerifyView extends StatefulWidget {
  const EmailVerifyView({Key? key}) : super(key: key);

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify your email")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  "Please check your email for a verification mail, if you have not received it press the button below"),
              TextButton(
                onPressed: () async {
                  context
                      .read<AuthBloc>()
                      .add(const AuthEventSendEmailVerification());
                },
                child: const Text("Send verification email"),
              ),
              TextButton(
                onPressed: () async {
                  context.read<AuthBloc>().add(const AuthEventLogout());
                },
                child: const Text("Restart process"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
