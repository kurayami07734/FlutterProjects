import 'package:flutter/material.dart';
import 'package:instagram_flutter/views/login_view.dart';

import '../views/register_view.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: const LoginView()));
  }
}
