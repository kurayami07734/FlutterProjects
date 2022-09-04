import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart' as theme;
import 'package:instagram_flutter/widgets/text_field_input.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/Flunstagram.svg',
                color: theme.primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              TextFieldInput(
                controller: _email,
                isPassword: false,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                controller: _password,
                isPassword: true,
                hintText: "Password",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
              TextButton(onPressed: () {}, child: const Text("Register here")),
            ],
          ),
        ),
      ),
    );
  }
}
