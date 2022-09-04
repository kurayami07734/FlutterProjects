import 'package:flutter/material.dart';
import 'package:instagram_flutter/views/login_view.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LoginView()));
  }
}
