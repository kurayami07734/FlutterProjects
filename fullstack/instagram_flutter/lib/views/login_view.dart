import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/colors.dart' as theme;
import 'package:instagram_flutter/utils/show_snackbar.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _isLoading = false;
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/Flunstagram.svg',
                color: theme.primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              Column(
                children: [
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
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  String res = await AuthMethods().login(
                    email: _email.text,
                    password: _password.text,
                  );
                  setState(() {
                    _isLoading = false;
                  });
                  showSnackBar(res, context);
                },
                child: _isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: theme.primaryColor,
                      )
                    : const Text("Login"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/register/', (route) => true);
                  },
                  child: const Text("Register here")),
              TextButton(
                onPressed: () async {
                  String res = await AuthMethods().logout();
                  showSnackBar(res, context);
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
