import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart' as theme;
import 'package:instagram_flutter/widgets/text_field_input.dart';
import '../resources/auth_methods.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _bio;
  late final TextEditingController _username;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _bio = TextEditingController();
    _username = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _bio.dispose();
    _username.dispose();
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
              Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage(
                            'assets/default-user-icon-8-300x300.jpg'),
                      ),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                              icon: const Icon(Icons.add_a_photo),
                              onPressed: (() {}))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFieldInput(
                    controller: _email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextFieldInput(
                    controller: _password,
                    isPassword: true,
                    hintText: "Password",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextFieldInput(
                    controller: _bio,
                    hintText: "Some words about yourself",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextFieldInput(
                    controller: _username,
                    hintText: "Username",
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  final bio = _bio.text;
                  final username = _username.text;
                  // await AuthMethods.registerUser(bio: bio, email: email, password: password, username: username, file: ,);
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
