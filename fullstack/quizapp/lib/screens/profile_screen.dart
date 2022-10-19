import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/shared/loading.dart';

import '../services/models.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    var user = AuthService().user;
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? "Guest"),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL ??
                        'https://www.gravatar.com/avatar/placeholder'),
                  ),
                ),
              ),
              Text(
                user.email ?? "",
                style: Theme.of(context).textTheme.headline6,
              ),
              // const SizedBox(height: 10),
              Text(
                report.total.toString(),
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Quizzes completed',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              // const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('logout'),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ],
          ),
        ),
      );
    }
    return const LoadingScreen();
  }
}
