import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String username = AuthService().user?.displayName ?? 'Guest';
    return Scaffold(
      appBar: AppBar(
        title: const Text('About this app'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Hello, $username',
              style: Theme.of(context).textTheme.headline4,
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 40),
            const Text(
                'I am an aspiring software developer, currently pursuing a bachelors\' degree in Electrical Engineering'),
            const Text(
                'Currently learning app development (Flutter + Firebase), this app is the result of my tinkering (more like copying fireship\'s'),
            const Text('course, but no one lives in a vacuum)'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    await launchUrlString('https://github.com/kurayami07734');
                  },
                  icon: const Icon(FontAwesomeIcons.github),
                  iconSize: 65,
                ),
                IconButton(
                  onPressed: () async {
                    await launchUrlString(
                        'https://www.linkedin.com/in/aditya-ghidora/');
                  },
                  icon: const Icon(FontAwesomeIcons.linkedin),
                  iconSize: 65,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
