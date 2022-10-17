import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;
  const LoginButton({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.loginMethod,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => loginMethod(),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        backgroundColor: color,
      ),
      label: Text(text),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(size: 150),
            Flexible(
              child: LoginButton(
                color: Colors.blue,
                icon: FontAwesomeIcons.google,
                text: 'Continue with Google',
                loginMethod: AuthService().googleLogin,
              ),
            ),
            Flexible(
              child: LoginButton(
                color: Colors.deepPurple,
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as a Guest',
                loginMethod: AuthService().anonLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
